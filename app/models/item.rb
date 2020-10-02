class Item < ApplicationRecord

  belongs_to :genre
  has_many :cart_items
  has_many :order_details

  attachment :image
  validates :name, {presence: true}
  validates :description, {presence: true}
  validates :price, {presence: true}
end
