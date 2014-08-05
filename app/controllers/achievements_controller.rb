class AchievementsController
  def confirm_mastery(command, skill)
    if Achievement.exists?(skill.id)
      Achievement.update_mastery(command, skill.id)
    else
      Achievement.new(skill_id: skill.id, mastered: command)
    end

    if command == "y"
      puts "Congrats! You have mastered #{skill.name}."
    else
      puts "Keep practicing #{skill.name}."
    end
  end
end
