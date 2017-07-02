require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(name: "Phuc", email: "phuc.tran@example.com", password: "123456", password_confirmation: "123456")
  end

  it 'should be valid' do
    expect(@user.valid?).to be_truthy
  end

  it 'should be invalid when name does not present' do
    @user.name = ""
    expect(@user.valid?).not_to be_truthy
  end

  it 'should be invalid when email does not present' do
    @user.email = ""
    expect(@user.valid?).not_to be_truthy
  end

  it 'should accept valid email' do
    valid_address = "user@example.com"
    @user.email = valid_address

    expect(@user.valid?).to be_truthy
  end

  it 'should reject invalid email' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user.valid?).not_to be_truthy
    end
  end

  it 'should have unique email addresses' do
    duplicate_user = @user.dup
    duplicate_user.email.upcase
    @user.save

    expect(duplicate_user.valid?).not_to be_truthy
  end

  it 'should be invalid when password does not present' do
    @user.password = @user.password_confirmation = " " * 6
    expect(@user.valid?).not_to be_truthy
  end

  it 'should have password with minimum length' do
    @user.password = @user.password_confirmation = "a" * 5
    expect(@user.valid?).not_to be_truthy
  end
end
