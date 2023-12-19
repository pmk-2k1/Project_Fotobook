class CreateLikePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :like_posts do |t|
      t.references :interact, polymorphic: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
