class Ticket < ActiveRecord::Base
  belongs_to :user
  has_many :comments


  validates :title, presence: true, uniqueness: true
  validates :content, presence: true, length: { maximum: 1400 }
  validates :user_id, presence: true

  default_scope -> { order(created_at: :desc) }

  def self.search(query)
    where("id = ?", "#{query}") 
  end
end
