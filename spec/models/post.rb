require "rails_helper"

RSpec.describe Post, type: :model do
  it "has a valid factory" do
    expect(build(:post)).to be_valid
  end

  context "with validations" do
    subject { create(:post) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
  end

  context "with associations" do
    subject { build(:post) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
  end
end