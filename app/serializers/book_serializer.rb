class BookSerializer < ActiveModel::Serializer
  attributes :id, :image, :author, :title
  has_many :reviews

  # def average_content_rating
  # 	object.reviews.average(:average_rating).to_i
  # end

  # def average_recommend_rating
  # 	object.reviews.average(:recommend_rating).to_i
  # end

end
