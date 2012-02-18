require 'spec_helper'
require "cancan/matchers"

describe Ability do
  describe "user" do
    let(:user){ Factory(:user) }
    let(:ability){ Ability.new(user) }

    context "whom created main event" do
        it "can update the event" do
          ability.should be_able_to(:update, Factory.create(:main_event, :user => user))
        end
    end

    context "reading main event" do
      it "cant read main event" do
        ability.should be_able_to(:read, Factory.create(:main_event))
      end
    end
  end
end