require 'spec_helper'

describe "MainEvents" do
  describe "GET /main_events" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get main_events_path
      response.status.should be(200)
    end
  end
end
