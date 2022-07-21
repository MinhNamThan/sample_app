class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  delegate :name, to: :user, prefix: :user, allow_nil: true

  validates :content, presence: true, length: { maximum: Settings.micropost.content.content_max_length }
  validates :image, content_type: {in: Settings.micropost.image_path, message: :not_valid},
                    size:{less_than: Settings.micropost.image_size.megabytes, message: :not_bigger}
  scope :newest, -> {order created_at: :desc}

  def display_image
    image.variant resize_to_limit: Settings.micropost.resize_to_limit
  end
end
