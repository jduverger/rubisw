class Wine < ApplicationRecord
  def self.alphabet
    find_by_sql("
      SELECT wines.*
      FROM wines
      ORDER by nom ASC
      ")
  end

  def self.couleur
    find_by_sql("
      SELECT wines.*
      FROM wines
      ORDER by couleur ASC
      ")
  end

  def self.millesime
    find_by_sql("
      SELECT wines.*
      FROM wines
      ORDER by millesime ASC
      ")
  end

  def self.regions
    find_by_sql("
      SELECT wines.*
      FROM wines
      ORDER by regions ASC
      ")
  end

  def self.cepage
    find_by_sql("
      SELECT wines.*
      FROM wines
      ORDER by cepage ASC
      ")
  end
  validates :nom, presence: true
  validates :couleur, presence: true
  validates :millesime, presence: true
end
