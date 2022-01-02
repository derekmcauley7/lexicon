class AlterWords < ActiveRecord::Migration[6.1]
  def up
    add_column("words", "audio", :string)
    add_column("words", "origin", :string, :limit => 600)
    add_column("words", "partOfSpeech", :string, :limit => 100)
    add_column("words", "definition", :string, :limit => 2000)
    add_column("words", "example", :string, :limit => 2000)
  end

  def down
    remove_column("words", "audio", :string)
    remove_column("words", "origin", :string, :limit => 600)
    remove_column("words", "partOfSpeech", :string, :limit => 100)
    remove_column("words", "definition", :string, :limit => 2000)
    remove_column("words", "example", :string, :limit => 2000)
  end
end
