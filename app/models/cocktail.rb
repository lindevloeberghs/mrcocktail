class Cocktail < ActiveRecord::Base
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses, dependent: :restrict_with_error
  # dependent destroy makes sure that all doses belonging to a cocktail are destroyed too when that cocktail is destroyed
  # dependent restrict prevents deletion of an ingredient when it's used by min 1 cocktails
  validates :name, presence: :true, uniqueness: :true
  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/
end
