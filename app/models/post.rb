class Post < ActiveRecord::Base
  include VoteableIankNov
  
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  
  before_save :generate_slug
  
  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true
  
  def generate_slug
    self.slug = self.title.gsub(' ', '-').downcase
  end
  
  def to_param
    self.slug
  end
end