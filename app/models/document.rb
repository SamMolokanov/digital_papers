class Document < ApplicationRecord
  has_one_attached :file

  belongs_to :user

  validates :user, presence: true

  validates :name,
    presence: true,
    uniqueness: { scope: :user_id },
    case_sensitive: false,
    length: { maximum: 255 }

  # TODO: refactor me, move to concern
  def name=(name_value)
    name_value.is_a?(String) ? super(name_value.downcase.strip) : super
  end
end
