require 'sqlite3'

class Environment

  def self.environment=(environment)
    @@environment = environment
  end

  def self.database
    unless @database
      @database = SQLite3::Database.open("db/#{@@environment}.sqlite")
      @database.execute "CREATE TABLE IF NOT EXISTS training_paths(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(29))"
      @database.execute "CREATE TABLE IF NOT EXISTS skills(id INTEGER PRIMARY KEY AUTOINCREMENT, training_path_id INTEGER, name VARCHAR(29), description text)"
      @database.execute "CREATE TABLE IF NOT EXISTS achievements(id INTEGER PRIMARY KEY AUTOINCREMENT, skill_id INTEGER, mastered BOOLEAN, mastered_at TIMESTAMP)"
    end
    @database
  end
end
