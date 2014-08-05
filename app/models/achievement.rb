class Achievement

  attr_reader :skill_id, :mastered, :mastered_at, :id

  def initialize(options)
    @id = options[:id]
    @skill_id = options[:skill_id]
    if (options[:mastered] == 1)
      @mastered = 1
      @mastered_at = Time.new.to_i
    else
      @mastered = 0
      @mastered_at = nil
    end
  end

  def master
    time = Time.new.to_i
    Environment.database.execute("UPDATE achievements SET mastered='1', mastered_at='#{time}' WHERE id='#{self.id}'")
    @mastered = 1
  end

  def mastered?
    row = Environment.database.execute("SELECT mastered, mastered_at FROM achievements WHERE id='#{self.id}'")[0]
    row[0] == 1 ? true : false
  end

  def save
    Environment.database.execute("INSERT INTO achievements (skill_id, mastered, mastered_at) VALUES ('#{@skill_id}', '#{@mastered}', '#{@mastered_at}')")
    @id = Environment.database.last_insert_row_id
  end

  def self.count
    Environment.database.execute("SELECT count(id) FROM achievements")[0][0]
  end

  def self.create(options)
    if (options[:mastered] == "y")
      options[:mastered] = 1
    else
      options[:mastered] = 0
    end
    achievement = Achievement.new(options)
    achievement.save
    achievement
  end

  def self.exists?(id)
    record = Environment.database.execute("SELECT * FROM achievements WHERE skill_id = '#{id}'")
    record.length > 0 ? true : false
  end

  def self.update_mastery(command, skill_id)
    time = Time.new.to_i
    if command == "y"
      Environment.database.execute("UPDATE achievements SET mastered='1', mastered_at='#{time}' WHERE skill_id ='#{skill_id}'")
    elsif command == "n"
      Environment.database.execute("UPDATE achievements SET mastered='0' WHERE skill_id ='#{skill_id}'")
    end
  end

  def self.last
    row = Environment.database.execute("SELECT id, skill_id, mastered, mastered_at FROM achievements ORDER BY id DESC LIMIT 1").last
    if row.nil?
      nil
    else
      Achievement.new(id: row[0], skill_id: row[1], mastered: row[2], mastered_at: row[3])
      # puts var.inspect
    end
  end

end
