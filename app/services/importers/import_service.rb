# frozen_string_literal: true

require "smarter_csv"
require "csv"

module Importers
  class ImportService < ApplicationService
    def initialize(file, user, resources_name)
      @csv_data = SmarterCSV.process(file, file_encoding: "bom|utf-8")
      @user = user
      @current_account = @user.account
      @error_string = []
      @resources_name = resources_name
    end

    def call
      @csv_data.first(import_limit).each do |data|
        record = initialize_resource(data)
        @error_string << (data.values + [record.full_message_errors]) unless record.save
      end

      send_acknowledgement_mail
    end

    private

    def send_acknowledgement_mail
      if @error_string.blank?
        ImportMailer.success(@user, @resources_name).deliver_now
      else
        ImportMailer.failure(@user, @resources_name, generate_error_csv).deliver_now
      end
    end

    def generate_error_csv
      CSV.generate(headers: true) do |csv|
        csv << error_csv_header
        @error_string.each { |row| csv << row }
      end
    end

    def import_limit
      (ENV["IMPORT_ROWS_LIMIT"].presence || 100).to_i
    end

    def sanitize_flag(flag)
      %w[yes true].include?(flag.to_s.strip.downcase)
    end

    def sanitize_risk_profile(risk_profile)
      risk_profile.to_s.strip.downcase.split.join("_")
    end

    def countries
      @countries ||= @current_account.countries
    end

    def find_country(name)
      countries.select { |c| c.name == name.to_s.strip }.first
    end
  end
end
