require 'spec_helper'

describe Event do
  describe "total_hours" do
    let!(:all_day_event) {FactoryGirl.create(:event, all_day: true)}
    let!(:five_hour_event) {FactoryGirl.create(:event, all_day: false, starts_at: DateTime.now, ends_at: DateTime.now + 5.hours)}
    before{ Rails.cache.clear }

    it "gets the total hours" do
      Event.total_hours.should == 8 + 5
    end  
  end
end