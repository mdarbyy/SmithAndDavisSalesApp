class SalesPerson < ApplicationRecord
  has_many :sales_records
  
  validate :unique_sales_person
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_save :capitalize_names
  before_destroy :find_records
  
  private 
  
  def capitalize_names
    self.first_name = capitalize_name(first_name) if first_name.present?
    self.last_name = capitalize_name(last_name) if last_name.present?
  end

  def capitalize_name(name)
    name.strip.split.map do |part|
      part[0] = part[0].upcase
      part
    end.join(" ")
  end
  
  def find_records
    if sales_records.exists?
      errors.add(:base, "There are Sales Records for this Sales Person")
      throw(:abort)
    end
  end
  
  def unique_sales_person
    duplicate = if persisted?
      # For updates, ignore the current record
      SalesPerson.where(first_name: first_name.capitalize, last_name: last_name.capitalize).where.not(id: id).exists?
    else
      # For new records
      SalesPerson.exists?(first_name: first_name.capitalize, last_name: last_name.capitalize)
    end

    if duplicate
      errors.add(:base, "This Sales Person already exists")
    end  

  end
end