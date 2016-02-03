class Priority < ActiveRecord::Base
	validates :name, :level, presence: true
end
