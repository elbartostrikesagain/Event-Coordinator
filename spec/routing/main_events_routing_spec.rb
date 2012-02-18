require "spec_helper"

describe MainEventsController do
  describe "routing" do

    it "routes to #index" do
      get("/main_events").should route_to("main_events#index")
    end

    it "routes to #new" do
      get("/main_events/new").should route_to("main_events#new")
    end

    it "routes to #show" do
      get("/main_events/1").should route_to("main_events#show", :id => "1")
    end

    it "routes to #edit" do
      get("/main_events/1/edit").should route_to("main_events#edit", :id => "1")
    end

    it "routes to #create" do
      post("/main_events").should route_to("main_events#create")
    end

    it "routes to #update" do
      put("/main_events/1").should route_to("main_events#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/main_events/1").should route_to("main_events#destroy", :id => "1")
    end

  end
end
