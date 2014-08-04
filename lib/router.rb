class Router
  def self.add_skill_description(skills_controller, skill)
    # clean_gets
    skills_controller.add_description(skill)
  end

  def self.mark_skill_as_mastered(skills_controller)
    command = clean_gets

    case command
    when "y"
      # do stuff
    when "n"
      # do other stuff
    else
      puts "I don't know the '#{command}' command."
    end
  end

  def self.navigate_skills_menu(skills_controller)
    command = clean_gets
    # The navigate_skills_menu interprets all input as "add",
    # thus it always calls the `add` action at this point.
    case command
    when "add"
      skills_controller.add
    when /\d+/
      skills_controller.view(command.to_i)
    else
      puts "I don't know the '#{command}' command."
    end
  end

  def self.navigate_training_paths_menu(training_paths_controller)
    command = clean_gets

    case command
    when "add"
      training_paths_controller.add
    when /\d+/
      training_paths_controller.view(command.to_i)
    else
      puts "I don't know the '#{command}' command."
    end
  end
end
