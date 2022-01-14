class CreateIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :ideas do |t|
      t.string :description
      t.string :user
      t.bigint :bucket_id
      t.jsonb :position
      t.string :color

      t.timestamps
    end
  end
end
