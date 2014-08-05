class SkillsController

  def initialize(origin_training_path)
    @origin_training_path = origin_training_path
  end

  def add
    puts "What #{@origin_training_path.name} skill do you want to add?"
    name = clean_gets
    skill = Skill.create(name: name, training_path: @origin_training_path)
    if skill.new_record?
      puts skill.errors
    else
      puts "#{name} has been added to the #{@origin_training_path.name} training path"
    end
    Router.add_skill_description(self, skill)
  end

  def add_description(origin_skill)
    puts "What is the description for #{origin_skill.name}?"
    description = clean_gets
    origin_skill.add_description(description)

    if origin_skill.errors
      puts origin_skill.errors
    else
      puts "#{origin_skill.name} skill has been updated with your description."
    end
  end

  def list
    puts "=============="
    puts "#{@origin_training_path.name.upcase} SKILLS"
    puts "=============="
    @origin_training_path.skills.each_with_index do |skill, index|
      puts "#{index + 1}. #{skill.name}"
    end
    Router.navigate_skills_menu(self)
  end

  def view(skill_number)
    skill = @origin_training_path.skills[(skill_number - 1)]
    if skill
      puts "=============="
      puts "#{skill.name.upcase}"
      puts "=============="
      puts "#{skill.description}"
      achievements_controller = AchievementsController.new
      Router.mark_skill_as_mastered(achievements_controller, skill)
    else
      puts "Sorry, skill #{skill_number} does not exist"
    end
  end

end
