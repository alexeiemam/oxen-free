class AddLikesCountToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :likes_count, :integer, default: 0
  end
end
