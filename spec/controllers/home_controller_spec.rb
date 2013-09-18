require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    context "assigns non-cached hours" do
      let(:total_hours) {85}
      before do
        Rails.cache.clear
        Event.stub(:total_hours).and_return(total_hours)
      end

      it "gets the total hours" do
        get 'index'
        assigns(:hours).should == total_hours
      end  
    end

    context "assigns cached hours" do
      let(:total_hours) {99999999}
      before{ Rails.cache.write(:total_hours, total_hours) }

      it "gets the total hours" do
        get 'index'
        assigns(:hours).should == total_hours
      end  
    end
    
  end

end
