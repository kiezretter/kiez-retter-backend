require 'csv'

class BusinessImport < ApplicationRecord
  has_many :businesses

  validates :content, presence: true

  def errored(name, exception)
    self.import_error ||= ""
    self.import_error += "#{name}: #{exception.inspect}\n"
  end

  def imported?
    !!imported_at
  end

  def destroy_businesses
    businesses.destroy_all
  end

  def num_imported
    businesses.count
  end
end
