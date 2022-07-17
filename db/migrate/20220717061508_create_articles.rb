class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.jsonb :source
      t.string :title, index: true
      t.integer :api_id, unique: true, index: true
      t.integer :api_collection_id, unique: true, index: true
      t.string :api_status, index: true
      t.string :api_section, index: true
      t.integer :api_view_count, index: true
      t.integer :api_like_count, index: true
      t.integer :api_impression_count, index: true
      t.integer :api_price, index: true
      t.integer :api_user_rating_number, index: true
      t.integer :api_user_rating_count, index: true
      t.integer :api_distance, index: true
      t.column :api_location, :point
      t.timestamp :api_created_at, index: true
      t.timestamp :api_updated_at, index: true
      t.timestamp :api_expires_at, index: true
      t.timestamp :published_at, index: true
      t.timestamps
    end
  end
end
