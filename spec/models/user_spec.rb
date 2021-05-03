require 'rails_helper'

RSpec.describe User, type: :model do
   # validation examples here
  it 'should create  User if all fields are valid' do
    @user = User.new(Firstname: "abd", Lastname: "sha", email: "abd@email.com", password: "123456", password_confirmation: "123456")
    expect(@user).to be_valid
  end

  it 'should not create  User without firstname' do
    @user = User.new(Firstname:nil, Lastname: "sha", email: "abd@email.com", password: "123456", password_confirmation: "123456")
    expect(@user).not_to be_valid
  end

  it 'should not create  User without last name' do
    @user = User.new(Firstname: "abd", Lastname: nil, email: "abd@email.com", password: "123456", password_confirmation: "123456")
    expect(@user).not_to be_valid
  end

  it 'should not create a User without an email' do
    @user = User.new(Firstname: "abd", Lastname: "sha", email:nil, password: "123456", password_confirmation:"123456" )
    @user.valid?
    expect(@user.errors.messages[:email]).to include("can't be blank")
    end
  it 'should not create a User if password and password confirmation do not match' do
      @user = User.new(Firstname: "abd", Lastname: "sha", email:"abdsha@email.com", password: "123456", password_confirmation:"12345678" )
      @user.valid?
      expect(@user.errors.messages[:password_confirmation]).to include("doesn't match Password")
    end
  it 'should not create User if the password is too short' do
    @user = User.new(Firstname:"abd", Lastname:"sha", email:"abdsha@email.com",password: "123", password_confirmation: "123")
    @user.valid?
    expect(@user.errors.messages[:password]).to include("is too short (minimum is 6 characters)")
  end
  it 'should not create a new User if email is not unique' do
    @user1 = User.new(Firstname: "abd", Lastname: "sha", email:"abdsha@email.com", password: "123456", password_confirmation:"123456" )
    @user1.save
    @user2 = User.new(Firstname: "max", Lastname: "james", email:"abdsha@email.com", password: "123456", password_confirmation:"123456" )
    @user2.valid?
    expect(@user2.errors.messages[:email]).to include("has already been taken")
  end
  it 'should not create a new user no password' do
    @user = User.new(Firstname:"abd", Lastname:"sha", email:"abdsha@email.com",password: nil, password_confirmation: nil)
    @user.valid?
    expect(@user.errors.messages[:password]).to include("can't be blank")
  end





  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should log the user in if the credentials are right' do
      @user = User.new(Firstname: "abd", Lastname: "sha", email: "abd@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save!
      expect(User.authenticate_with_credentials("abd@gmail.com", "123456")).to be_present
    end

    it 'should not log the user in if the email is wrong' do
      @user = User.new(Firstname: "abd", Lastname: "sha", email: "abd@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save!
      expect(User.authenticate_with_credentials("abdulll@gmail.com", "123456")).not_to be_present
    end

    it 'should not log the user in if the password is wrong' do
      @user = User.new(Firstname: "abd", Lastname: "sha", email: "abd@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save!
      expect(User.authenticate_with_credentials("abd@gmail.com", "12345678")).not_to be_present
    end

    it 'should not log the user in if the email is wrong' do
      @user = User.new(Firstname: "abd", Lastname: "sha", email: "abd@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save!
      expect(User.authenticate_with_credentials("abduuuuu@gmail.com", "123456")).not_to be_present
    end

    it 'should log the user in even if the email contains spaces' do
      @user = User.new(Firstname: "abd", Lastname: "sha", email: "abd@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save!
      expect(User.authenticate_with_credentials("  abd@gmail.com   ", "123456")).to be_present
    end

    it 'should log the user in if the email has different letter casing' do
      @user = User.new(Firstname: "abd", Lastname: "sha", email: "abd@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save!
      expect(User.authenticate_with_credentials("abd@gmail.com", "123456")).to be_present
    end

  end

  
end
