class CreateUsers < ActiveRecord::Migration[6.1]
  def up
    create_table :users do |t|
      t.column "first_name", :string, :limit => 25
      t.string "last_name", :limit => 50
      t.string "email", :default => '', :null => false
      t.string "password", :limit => 500
      t.string "password_digest", :string, :limit => 500
      t.timestamps
    end
  end

  def down
    drop_table :users
  end

end
