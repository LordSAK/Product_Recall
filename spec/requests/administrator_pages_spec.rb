require 'spec_helper'

describe "Administrator Pages" do

describe "Home page" do

    it "should have the h1 'Home'" do
      visit '/administrator_pages/home'
      page.should have_selector('h1', :text => 'Home')
    end

    it "should have the title 'Home'" do
      visit '/administrator_pages/home'
      page.should have_selector('title',
                        :text => "Home")
    end
  end
end