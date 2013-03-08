require 'spec_helper'
require "cancan/matchers"

describe Ability do
  describe "user" do
    let(:user){ FactoryGirl.create(:user) }
    let(:ability){ Ability.new(user) }

    context "whom created main event" do
      it "can update the event" do
        ability.should be_able_to(:update, FactoryGirl.create(:main_event, :user => user))
      end
      it "can update an event" do
        main_event = FactoryGirl.create(:main_event, :user => user)
        ability.should be_able_to(:update, FactoryGirl.create(:event, :main_event => main_event))
      end
    end

    context "whom did not create main event" do
      it "cant read main event" do
        ability.should be_able_to(:read, FactoryGirl.create(:main_event))
      end
      it "cant update an event" do
        ability.should_not be_able_to(:update, FactoryGirl.create(:event))
      end
    end
  end
end