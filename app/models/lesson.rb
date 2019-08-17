class Lesson < ApplicationRecord
	belongs_to :section
	mount_uploader :video, VideoUploader

	# validates :enrollment, presence: true

	include RankedModel
	ranks :row_order, with_same: :section_id
end
