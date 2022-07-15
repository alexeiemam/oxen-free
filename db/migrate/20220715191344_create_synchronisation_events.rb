class CreateSynchronisationEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :synchronisation_events do |t|
      t.timestamp   :last_checked_at, index: true
      t.timestamp   :completed_at, index: true
      t.timestamp   :errored_at, index: true
      t.jsonb       :report
      t.timestamps
    end
  end
end
