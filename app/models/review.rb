class Review < ApplicationRecord
  before_validation	:parse_image	
  attr_accessor :review_image	

  before_save :calculate_average_rating	
  belongs_to :user
  belongs_to :book

  has_attached_file :picture, styles: {medium: "300×300>",thumb: "100×100>"}
  validates_attachment :picture, presence: true
  do_not_validate_attachment_file_type :picture

  def calculate_average_rating
  	self.average_rating = ((average_rating.to_f + recommend_rating.to_f)/2).round(1)
  end

  private

  def parse_image
  	image = Paperclip.io_adapters.for(review_image)
  	image.original_filename = "test.jpg"
  	self.picture = image
  end

end
