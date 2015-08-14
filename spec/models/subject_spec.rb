RSpec.describe Subject, type: :model do
  describe "create subject" do
    context "valid name subject" do
      let(:subject){FactoryGirl.create :subject}
      it{expect(subject.errors).to be_empty}
    end
    context "invalid name subject" do
      let(:subject){Subject.create FactoryGirl.attributes_for :invalid_name_subject}
      it{expect(subject.errors[:name]).to be_present}
    end
  end

  describe "association" do
    it{expect have_many :user_subjects}
    it{expect have_many :course_subjects}
    it{expect have_many :tasks}
    it{expect have_many(:user_tasks).through :tasks}
    it{expect have_many(:courses).through :course_subjects}
    it{expect have_many(:users).through :user_subjects}
  end
end
