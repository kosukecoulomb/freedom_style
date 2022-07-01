class Report < ApplicationRecord
  
  belongs_to :comment
  belongs_to :coordinate
  belongs_to :item
  has_one :user
  
  enum report_class: { hate:0, sexual:1, harassment:2, spam: 3, infringement:4}
end
