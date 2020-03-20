# frozen_string_literal: true

json.array! @owners, partial: 'owners/owner', as: :owner
