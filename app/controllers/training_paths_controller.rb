class TrainingPathsController

  def add
    puts "What training path do you want to add?"
    name = clean_gets
    training_path = TrainingPath.create(name: name)
    if training_path.new_record?
      puts training_path.errors
    else
      puts "#{name} has been added to the list of training paths"
    end
  end

  def list
    puts "=============="
    puts "TRAINING PATHS"
    puts "=============="
    training_paths.each_with_index do |training_path, index|
      puts "#{index + 1}. #{training_path.name}"
    end
  end

  def view(path_number)
    training_path = training_paths[path_number - 1]
    if training_path
      puts "We're headed down the path to #{training_path.name}!"
      training_path.skills.each_with_index do |skill, index|
        puts "#{index + 1}. #{skill.name}"
      end
      clean_gets
      add_skill_to_training_path(training_path)
    else
      puts "Sorry, training path #{path_number} doesn't exist."
    end
  end

  def training_paths
    @training_paths ||= TrainingPath.all
  end
end
