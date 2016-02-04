class Ticket < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  belongs_to :user
  has_many :comments

  def self.search(query)
    where("id = ?", "#{query}") 
  end
end
