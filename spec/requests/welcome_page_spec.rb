# encoding: UTF-8

require "spec_helper"

feature "welcome page" do
  background do
    create(:presentation)
  end

  scenario "visit root path" do
    visit '/'

    page.should have_content('Łódź Ruby User Group')

    within '.info' do
      page.should have_content('1 września 2011, 10:00')
      page.should have_content('Łąkowa 11, biuro Ragnarson, 1. piętro')
      page.should have_content('Budynek główny (ceglany), 1. klatka')
    end

    page.should have_selector('.map')

    within 'ol.presentations' do
      page.should have_selector('.presentation')
      within 'li.presentation' do
        page.should have_selector('.topic')
        page.should have_selector('.author')
      end
    end

    within 'footer' do
      page.should have_link('wcześniejsze prezentacje', href: events_path)
      page.should have_link('kod źródłowy', href: 'https://github.com/bkzl/lrug.pl')
    end
  end

  scenario "click link to previous events" do
    visit '/'
    click_link 'wcześniejsze prezentacje'
    current_path.should == events_path
    within 'ol.events' do
      page.should have_selector('.event')
      within 'li.event' do
        page.should have_selector('.date', text: '1 września 2011')
        page.should have_selector('ul.presentations')
      end
    end
  end
end