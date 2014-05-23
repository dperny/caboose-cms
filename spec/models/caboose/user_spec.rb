require 'spec_helper'

module Caboose
  describe User do
    before { @user = User.new(email: 'drew@nine.is') }
    subject { @user }

    it { should respond_to(:email) }
    it { should respond_to(:first_name) }
  end
end
