class CreateArticleSynchronisationChangeLog < ActiveRecord::Migration[7.0]
  def change
    create_table :article_synchronisation_change_logs do |t|
      t.references :article, null: true, foreign_key: true, index: { name: 'article_on_sync_change_log_idx' }
      t.references :synchronisation_event, null: false, foreign_key: true, index: { name: 'event_on_sync_change_log_idx' }
      t.jsonb      :changes
      t.timestamps
    end
  end
end
