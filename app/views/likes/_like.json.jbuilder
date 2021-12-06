json.extract! like, :id, :user_id, :comment_id, :like_type, :created_at, :updated_at
json.url like_url(like, format: :json)
