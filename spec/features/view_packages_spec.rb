require 'rails_helper'

feature 'View packages', %q{
  As an user
  I want to view packages
  In order to see all packages and specific package info
} do
  let!(:package_1) { Package.create!(name: 'A3', version: '0.9.2', title: 'A3: Accurate, Adaptable') }
  let!(:package_2) { Package.create!(name: 'abc', version: '2.0', title: 'ABC: ABC TITLE') }

  background do
    visit '/'
  end

  it 'must show list of packages with name, version and title' do
    expect(page).to have_text(package_1.name)
    expect(page).to have_text(package_1.version)
    expect(page).to have_text(package_1.title)

    expect(page).to have_text(package_2.name)
    expect(page).to have_text(package_2.version)
    expect(page).to have_text(package_2.title)

  end

  scenario 'when user want to see more info about selected package' do
  end
end
