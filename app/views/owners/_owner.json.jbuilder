# frozen_string_literal: true

json.extract! owner, :id, :created_at, :updated_at
json.url owner_url(owner, format: :json)
