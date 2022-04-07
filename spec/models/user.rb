require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it "does not allow identical email and username" do
    create(:user, username: 'test@test.com')
    
    user = User.new(
      username: 'test@test.com',
      email: 'test@test.com',
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user).not_to be_valid
  end

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is valid with a username, email, and password" do
    user = User.new(
      username: "test-user",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user).to be_valid
  end

  it "uses username for login" do
    user = User.new(
      username: "test-user",
      email: nil,
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user.login).to eq(user.username)
  end

  it "uses email for login" do
    user = User.new(
      username: nil,
      email: 'test@test.com',
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user.login).to eq(user.email)
  end

  describe '.find_for_database_authentication' do
    let(:user) { create(:user) }
    
    it "finds user by email" do
      warden_conditions = { email: user.email }
      authenticated = User.find_for_database_authentication(warden_conditions)
      expect(authenticated).to eql user 
    end
    
    it "finds user by username" do
      warden_conditions = { username: user.username }
      authenticated = User.find_for_database_authentication(warden_conditions)
      expect(authenticated).to eql user 
    end    
  end

end
