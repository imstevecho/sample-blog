require "rails_helper"

RSpec.describe Comment, type: :model do
  it "has a valid factory" do
    expect(build(:comment)).to be_valid
  end

  context "with validations" do
    subject { create(:comment) }

    it { is_expected.to validate_presence_of(:body) }
  end

  context "with associations" do
    subject { build(:comment) }

    it { is_expected.to belong_to(:post) }
    it { is_expected.to belong_to(:user) }
  end
end