require 'spec_helper'

describe MainEvent do
  let(:main_event) {Factory.create :main_event}
  describe "first event date" do
    context "doesnt have events" do
      it "returns a blank date" do
        main_event.first_event_date.should == " / / "
      end
    end
    context "has events" do
      it "return the date of the first event" do
        event2 = Factory.create(:event, main_event: main_event, starts_at: Time.now)
        event1 = Factory.create(:event, main_event: main_event, starts_at: Time.now - 1.day)
        main_event.events = [event2, event1]
        main_event.first_event_date.should == event1.starts_at.strftime("%m/%d/%Y")
      end
    end
  end

end
