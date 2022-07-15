class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.integer :api_id, unique: true, index: true
      t.timestamp :published_at, index: true
      t.jsonb :source
      t.timestamps
    end
  end
end
