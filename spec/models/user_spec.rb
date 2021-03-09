require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
  end

  it 'creates api_key' do
    user = create :user
    expect(user.api_key).to_not be_nil
  end

  it 'all api keys are unique' do
    users = create_list(:user, 5)

    keys = users.map { |user| user.api_key }

    i = 0
    keys.any? do |key|
      i += 1
      key == keys[i]
    end
  end
end
