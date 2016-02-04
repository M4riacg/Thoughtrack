class Ticket < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  belongs_to :user
  has_many :comments

  def self.search(query)
    where("id = ?", "#{query}") 
  end

  filterrific(
  default_filter_params: { sorted_by: 'priority_id' },
  available_filters: [
    :sorted_by,
    :search_query,
    :with_title,
    :with_created_at_gte
  ]
)
end
