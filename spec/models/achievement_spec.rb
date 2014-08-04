RSpec.describe Achievement do
  let!(:training_path){ TrainingPath.create(name: "Fighting") }
  let!(:skill){ Skill.create(name: "Punching", description: "Move your hand fastly.", training_path: training_path) }
  let!(:skill2){ Skill.create(name: "Kicking", description: "Move your foot fastly.", training_path: training_path) }

  context ".count" do
    it "returns 0 if there are no records" do
      expect(Achievement.count).to eq 0
    end
    it "returns the right number if there are records" do
      Environment.database.execute("INSERT INTO achievements(skill_id, mastered, mastered_at) VALUES('#{skill.id}', false, nil)")
      Environment.database.execute("INSERT INTO achievements(skill_id, mastered, mastered_at) VALUES('#{skill2.id}', false, nil)")
      expect(Achievement.count).to eq 2
    end
  end

  context ".create" do
    context "with valid input" do
      it "should successfully create an achievement that has been mastered" do
        let!(:achievement){ Achievement.create(skill_id: skill.id, mastered: true, mastered_at: Time.new.to_i) }
        expect(Achievement.last.skill_id).to eq skill.id
        expect(Achievement.last.mastered).to eq true
      end

      it "should successfully create an achievement that has not been mastered" do
        let!(:achievement){ Achievement.create(skill_id: skill.id, mastered: false) }
        expect(Achievement.last.skill_id).to eq skill.id
        expect(Achievement.last.mastered).to eq false
        expect(Achievement.last.mastered_at).to eq nil
      end
    end

    context "with invalid input" do
      it "should not create an achievement" do
        expect(Achievement.count).to eq 0
      end
    end
  end

  context ".last" do
    context "if there are no records" do
      it "should return nil" do
        expect(Achievement.last).to be_nil
      end
    end

    context "if there are several records" do
      let!(:achievement1){ Achievement.create(skill_id: skill.id, mastered: false) }
      let!(:achievement2){ Achievement.create(skill_id: skill2.id, mastered: true, mastered_at: Time.new.to_i) }

      it "should return the record that was created last, with correct skill_id" do
        expect(Achievement.last.skill_id).to eq skill2.id
      end
      it "should return the record that was created last, with correct mastered status" do
        expect(Achievement.last.mastered).to eq true
      end
      it "should return the record that was created last, with correct mastered_at value" do
        expect(Achievement.last.mastered_at).to eq achievement2.mastered_at
      end
    end
  end

  context "#master" do
    it "should update the mastered attribute" do
      let!(:achievement1){ Achievement.create(skill_id: skill.id, mastered: false) }
      achievement1.master
      expect(achievement1.mastered).to eq true
    end
  end

end
