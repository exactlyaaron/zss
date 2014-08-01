require 'sqlite3'

class Environment

  def self.environment=(environment)
    @@environment = environment
  end

  def self.database
    unless @database
      @database = SQLite3::Database.open("db/#{@@environment}.sqlite")
      @database.execute "CREATE TABLE IF NOT EXISTS training_paths(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(29))"
      @database.execute "CREATE TABLE IF NOT EXISTS skills(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(29), description TEXT, training_path_id INTEGER, FOREIGN KEY(training_path_id) REFERENCES training_path(id))"
    end
    @database
  end
end
