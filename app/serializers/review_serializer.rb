class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :content_rating, :recommend_rating, :title, :average_rating, :picture
  belongs_to :book

end
