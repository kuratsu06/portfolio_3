json.extract! content, :id, :user_id, :complete_id, :comment, :created_at, :updated_at
json.url comment_url(content, format: :json)
