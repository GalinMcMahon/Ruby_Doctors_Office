require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the task path', {:type => :feature}) do
  it('processes the user entry and makes a list item') do
    visit('/')
    fill_in('description', :with => 'hello')
    click_button('Add task')
    expect(page).to have_content('hello')
  end
end
