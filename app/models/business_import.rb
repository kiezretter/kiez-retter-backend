require 'csv'

class BusinessImport < ApplicationRecord
  validates :content, presence: true

  after_create do
    ImportBusinessesJob.perform_later self
  end

  def imported!(count)
    self.imported_at = Time.now
    self.num_imported = count
    self.save!
  end

  def errored!(exception)
    self.import_error = exception.inspect
    self.save!
  end

  def imported?
    !!imported_at
  end
end
