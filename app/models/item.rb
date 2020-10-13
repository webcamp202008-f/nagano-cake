class Item < ApplicationRecord

  belongs_to :genre
  has_many :cart_items
  has_many :order_details

  attachment :image
  validates :name, {presence: true}
  validates :introduction, {presence: true}
  validates :price, {presence: true}

      def self.search(word,search)
        if search == "perfect_match"
             @item = Item.where("name LIKE?","#{word}")
        elsif search == "partial_match"
             @item = Item.where("name LIKE?","%#{word}%")
        else
             @item = Item.all
        end
      end
end
