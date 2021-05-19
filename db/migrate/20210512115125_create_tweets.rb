class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :title,     null: false
      t.text :text,        null: false
      t.integer :job_id,   null: false
      t.integer :status_id,null: false
      t.references :user,  foreign_key: true
      t.timestamps
    end
  end
end
