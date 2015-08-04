class UserTag < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :tag, dependent: :destroy

  validates :user_id, uniqueness: { scope: :tag_id, message: "Duplicate tag" }
end
