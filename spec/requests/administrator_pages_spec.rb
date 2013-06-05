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
  
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end

describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
  

  
end