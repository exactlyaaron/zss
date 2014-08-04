RSpec.describe "Adding descriptions to skills" do
  context "valid input" do
    let!(:training_path1){ TrainingPath.create(name: "Weapon Skills") }
    let!(:training_path2){ TrainingPath.create(name: "Running") }
    let!(:output){ run_zss_with_input("2", "add", "Jogging", "Here is a description for jogging.") }

    it "prints a success message" do
     expect(output).to include("Jogging skill has been updated with your description.")
    end

    it "saves the description to the record" do
      expect(Skill.last.description).to include("Here is a description for jogging.")
    end

  end
  context "invalid input" do
    let!(:training_path){ TrainingPath.create(name: "Running") }
    let!(:output){ run_zss_with_input("1", "add", "Jogging", "") }

    it "prints an error message" do
      expect(output).to include("description cannot be blank")
    end

    it "doesn't add a description" do
      expect(Skill.last.description).to eq ""
    end
  end
end
