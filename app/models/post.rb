class Post < ApplicationRecord
  belongs_to :user

  mount_uploader :video, VideoUploader

  enum post_type: %i(video youtube)

  validates :title, :post_type, :user_id, presence: true
  validate :posts_deplication_checker

  def posts_deplication_checker
    if video.present? && youtube.present?
      errors[:base] << "コンテンツが重複しています"
    elsif youtube.blank? && video.blank?
      errors[:base] << "コンテンツがありません"
    end
  end
end