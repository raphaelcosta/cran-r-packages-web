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

 feature 'when user want to see more info about selected package' do
    before do
      package_1.title = 'A3: Accurate, Adaptable, and Accessible Error Metrics for Predictive Models'
      package_1.authors = ['Scott Fortmann-Roe']
      package_1.date_publication = '2013-03-26 19:58:40'
      package_1.maintainer_email = 'scottfr@berkeley.edu'
      package_1.maintainer_name = 'Scott Fortmann-Roe'
      package_1.description = 'This package supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.'
      package_1.save
    end

    it 'must render all package info' do
      click_link package_1.name

      expect(page).to have_text(package_1.name)
      expect(page).to have_text(package_1.version)
      expect(page).to have_text(package_1.title)
      expect(page).to have_text(package_1.authors.join(', '))
      expect(page).to have_text(package_1.date_publication)
      expect(page).to have_text(package_1.maintainer_email)
      expect(page).to have_text(package_1.maintainer_name)
      expect(page).to have_text(package_1.description)
    end
  end
end
