require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  
  
  
  it { should validate_presence_of(:name) }
  it { should allow_value('1234567890').for(:phone) }
  it { should allow_value('(123)456-7890').for(:phone) }
  it { should allow_value('123-456-7890').for(:phone) }
  it { should_not allow_value('123').for(:phone) }
  it { should_not allow_value('abcdefghij').for(:phone) }
  it { should_not allow_value('12345678901').for(:phone) }



end
