class Idea < ApplicationRecord
  belongs_to :bucket, optional: true
end
