RSpec.describe "Viewing the details of a specific skill" do
  let!(:path1){ TrainingPath.create(name: "Running") }
  let!(:path2){ TrainingPath.create(name: "Hand-to-Hand Combat") }

  context "a skill that is in the list" do
    let(:output){ run_zss_with_input('1', '1') }

    before do
      Skill.create(name: "with Scissors", training_path: path1, description: "Make sure you do not trip and fall on the scissors.")
      Skill.create(name: "like a Zombie", training_path: path1, description: "Glazed eyes, drool a lot, snarl like you want to eat brains")
    end

    it "should include the name of the skill being viewed" do
      expected =<<EOS
==============
WITH SCISSORS
==============
EOS
      expect(output).to include expected
    end

    it "should include the description of the skill being viewed" do
      expect(output).to include("Make sure you do not trip and fall on the scissors.")
    end
  end

  context "a skill that does not exist" do
    let(:output){ run_zss_with_input('2', '3') }

    it "should print an error message" do
      expect(output).to include("Sorry, skill 3 does not exist")
    end
  end
end
