class Notification < ApplicationRecord
  # デフォルトの並び順を「作成日時の降順」で指定
  default_scope -> { order(created_at: :desc) }

  belongs_to :coordinate, optional: true
  belongs_to :comment, optional: true

  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
end
