require 'csv'

class BusinessImport < ApplicationRecord
  has_many :businesses

  validates :content, presence: true

  def imported!(count)
    self.imported_at = Time.now
    self.save!
  end

  def errored!(exception)
    self.import_error = exception.inspect
    self.save!
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
