# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are: :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  cattr_accessor :current_user

  before_validation :set_account_id

  strip_attributes only: %i[first_name last_name email], collapse_spaces: true, replace_newlines: true

  belongs_to :account, counter_cache: true

  has_many :page_settings, dependent: :destroy
  has_many :filter_options, dependent: :destroy

  validates :first_name, :last_name, :email, presence: true, length: { maximum: 250 }

  def find_page_setting(find_page_setting)
    page_settings.find_by(find_page_setting) || page_settings.create(find_page_setting)
  end

  def initial
    "#{first_name[0]}#{last_name[0]}".upcase
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  private

  def set_account_id
    self.account_id = Account.first.id
  end
end
