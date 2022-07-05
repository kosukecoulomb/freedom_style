class Report < ApplicationRecord
  
  belongs_to :comment
  belongs_to :reporting, class_name: "User"

end
