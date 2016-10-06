json.extract! posting, :id, :title, :description, :condition, :category, :full_address, :availability, :created_at, :updated_at
json.url posting_url(posting, format: :json)