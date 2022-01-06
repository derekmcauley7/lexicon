class AlterUsers < ActiveRecord::Migration[6.1]
  def up
    add_column("users", "username", :string)
  end

  def down
    remove_column("users", "username", :string)
  end

end
