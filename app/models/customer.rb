class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :family_name,presence: true
  validates :first_name,presence: true
  validates :family_name_kana,presence: true
  validates :first_name_kana,presence: true
  validates :post_code,presence: true, length:{is: 7}
  validates :phone_number,presence: true

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

    def active_for_authentication?
      super && self.is_active == false
    end

    def self.search(word,search)
        if search == "perfect_match"
             @customer = Customer.where(["family_name LIKE? AND first_name LIKE?","%#{word}%","%#{word}%"])
        elsif search == "partial_match"
             @customer = Customer.where(["family_name LIKE? OR first_name LIKE?","%#{word}%","%#{word}%"])
        else
             @customer = Customer.all
        end
    end


end

