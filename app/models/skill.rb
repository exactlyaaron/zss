class Skill
  include Comparable
  attr_reader :description, :errors, :id, :name

  def initialize(options)
    @errors = nil
    @id = options[:id]
    @training_path_id = options[:training_path_id]
    @training_path = options[:training_path]
    @name = options[:name]
    @description = options[:description]
  end

  def add_description(description)
    @description = "#{description}"
    if valid?("description")
      Environment.database.execute("UPDATE skills SET description='#{description}' WHERE id='#{self.id}'")
    end
  end

  def training_path_id
    @training_path ? @training_path.id : @training_path_id
  end

  def self.all(sql_fragment = "")
    results = []
    Environment.database.execute("SELECT id, name, description, training_path_id FROM skills #{sql_fragment}").each do |row|
      results << Skill.new(id: row[0], name: row[1], description: row[2], training_path_id: row[3])
    end
    results
  end

  def self.count
    Environment.database.execute("SELECT count(id) FROM skills")[0][0]
  end

  def self.create(options)
    skill = Skill.new(options)
    skill.save
    skill
  end

  def self.last
    row = Environment.database.execute("SELECT id, name, description, training_path_id FROM skills ORDER BY id DESC LIMIT 1").last
    if row.nil?
      nil
    else
      Skill.new(id: row[0], name: row[1], description: row[2], training_path_id: row[3])
    end
  end

  def save
    if valid?
      Environment.database.execute("INSERT INTO skills (name, description, training_path_id) VALUES ('#{@name}', '#{@description}', #{training_path_id})")
      @id = Environment.database.last_insert_row_id
    end
  end

  def new_record?
    @id.nil?
  end

  def valid?(type="name")
    case type
      when "name"
        validate_name
      when "description"
        validate_description
      else
        @errors.nil?
    end
    @errors.nil?
  end

  def <=>(other)
    self.id <=> other.id
  end

  private

  def validate_name
    if @name.empty?
      @errors = "name cannot be blank"
    elsif training_path_id.nil?
      @errors = "training path cannot be blank"
    else
      @errors = nil
    end
  end

  def validate_description
    if @description.empty?
      @errors = "description cannot be blank"
    else
      @errors = nil
    end
  end

end
