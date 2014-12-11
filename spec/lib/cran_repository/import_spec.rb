require 'rails_helper'

describe CranRepository::Import do
  describe '.call' do
    before do
      packages_contents = File.read('spec/fixtures/PACKAGES')
      stub_request(:get, 'cran.r-project.org/src/contrib/PACKAGES').to_return(status: 200, body: packages_contents)
    end

    context "when we dont have any of returned repositories" do
      it 'must save all new packages infos' do
        expect{ CranRepository::Import.call }.to change{Package.count}.by(3)
      end
    end
  end
end
