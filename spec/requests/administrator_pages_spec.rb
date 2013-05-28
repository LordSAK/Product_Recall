require 'spec_helper'

describe "Administrator Pages" do

 subject { page }


  describe "ChangeFeatures" do
    before { visit "administrator_pages/ChangeFeatures" } 
    it {should have_selector('h2', :text => "Change Features")}
    
    it{should have_selector('title', :text => "Change Features")}
  end

 describe "ChangeAlerts" do
  before { visit "administrator_pages/ChangeAlerts" }
    it {should have_selector('h2', :text => "Change Product Recalls")}
    it {should have_selector('title', :text => "Change Product Recalls")}

  end

 describe "ShiftSubscriber" do
  before { visit "administrator_pages/ShiftSubscriber" }
    it {should have_selector('h2', :text => "Shift Subscribers")}
    it {should have_selector('title', :text => "Shift Subscribers")}

  end
end