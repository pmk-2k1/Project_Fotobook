class CreateFollowUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :follow_users do |t|
      t.references :following, index: true, foreign_key: { to_table: :users }
      t.references :follower, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end

  end
end
