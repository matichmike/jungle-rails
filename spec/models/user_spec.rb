require 'rails_helper'

RSpec.describe User, type: :model do
  subject = User.new(email: "geralt@rivia.com", first_name: "Geralt", last_name: "OfRivia", password: "TeamShani", password_confirmation: "TeamShani")
  
  describe 'Validations' do
    it "has valid attributes" do
      expect(subject).to be_valid
  end

  it 'invalid if password confirmation not matching' do
    subject.password_confirmation = "TeamYennefer"
    expect(subject).to be_invalid
  end

  it 'invalid if password confirmation is blank' do
    subject.password_confirmation = nil
    expect(subject).to be_invalid
  end

  it "invalid if email is already taken, not case sensitive" do
    subject = User.new(email: "geralt@rivia.com", first_name: "Geralt", last_name: "OfRivia", password: "TeamShani", password_confirmation: "TeamShani")
    subject.save!
    @user = User.new(email: "Geralt@Rivia.com", first_name: "Geralt", last_name: "OfRivia", password: "TeamShani", password_confirmation: "TeamShani")
    expect(@user).to be_invalid
  end

  it "invalid if email is not available" do
    subject.email = nil
    expect(subject).to be_invalid
  end

  it "invalid if first_name is not available" do
    subject.first_name = nil
    expect(subject).to be_invalid
  end

  it "invalid if last_name is not available" do
    subject.last_name = nil
    expect(subject).to be_invalid
  end

  it "invalid if password length < 6" do
    subject.password = "hey"
    subject.password_confirmation = "hey"
    expect(subject).to be_invalid
  end

end

describe '.authenticate_with_credentials' do
  before(:each) do
    subject = User.new(email: "geralt@rivia.com", first_name: "Geralt", last_name: "OfRivia", password: "TeamShani", password_confirmation: "TeamShani")
    subject.save!
  end

  it "is valid if email and password match" do
    user = User.authenticate_with_credentials(subject.email, subject.password)
    expect(user).to be_instance_of(User)
    expect(user.id).to eq(subject.id)
  end

  it "invalid if email does not match" do
    user = User.authenticate_with_credentials("gaunter@odimm.com", subject.password)
     expect(user).not_to be_instance_of(User)
  end

  it "valid if email has extra spaces" do
    user = User.authenticate_with_credentials("  geralt@rivia.com  ", subject.password)
    expect(user).to be_instance_of(User)
    expect(user.id).to eq(subject.id)
  end

  it "valid if email case is different" do
    user = User.authenticate_with_credentials("Geralt@Rivia.com", subject.password)
    expect(user).to be_instance_of(User)
    expect(user.id).to eq(subject.id)
  end

  it "invalid if password does not match" do
    user = User.authenticate_with_credentials(subject.email, "not_good")
    expect(user).not_to be_instance_of(User)
  end

end

end