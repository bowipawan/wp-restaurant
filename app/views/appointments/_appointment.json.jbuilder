json.extract! appointment, :id, :user_id, :table_id, :time_start, :people_amount, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
