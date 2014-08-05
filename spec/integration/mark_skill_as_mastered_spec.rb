RSpec.describe "Mastering skills" do
  context "valid input" do
    let!(:training_path1){ TrainingPath.create(name: "Weapon Skills") }
    let!(:training_path2){ TrainingPath.create(name: "Running") }
    let!(:skill1){ Skill.create(name: 'Jogging', description: 'Here is a description for jogging', training_path: training_path2) }

    context "mastered" do
      let(:output){ run_zss_with_input("2", "1", "y") }

      it "prints a success message" do
       expect(output).to include("Congrats! You have mastered Jogging.")
      end
    end

    context "not mastered" do
      let(:output){ run_zss_with_input("2", "1", "n") }

      it "prints a success message" do
       expect(output).to include("Keep practicing Jogging.")
      end
    end


  end

  context "invalid input" do
    let!(:training_path){ TrainingPath.create(name: "Running") }
    let!(:skill1){ Skill.create(name: 'Jogging', description: 'Here is a description for jogging', training_path: training_path) }
    let!(:output){ run_zss_with_input("1", "1", "567u89") }

    it "prints an error message" do
      expect(output).to include("I don't know the '567u89' command.")
    end
  end
end
