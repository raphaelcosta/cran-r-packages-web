require 'rails_helper'

describe CranRepository::Import do
  describe '.call' do
    before do
      packages_contents = File.read('spec/fixtures/PACKAGES')
      stub_request(:get, 'http://cran.r-project.org/src/contrib/PACKAGES').to_return(status: 200, body: packages_contents)

      packages_to_mock = [CranRepository::Package.new('A3','0.9.2'),
                          CranRepository::Package.new('abc','2.0'),
                          CranRepository::Package.new('abcdeFBA','0.4')]

      packages_to_mock.each do |p|
        filename = p.filename
        package_file = File.read("spec/fixtures/#{filename}")
        stub_request(:get, "cran.r-project.org/src/contrib/#{filename}").to_return(status: 200, body: package_file)
      end
    end

    context "when we dont have any of returned repositories" do
      it 'must save all new packages infos' do
        expect{ CranRepository::Import.call }.to change{Package.count}.by(3)

        first_package = Package.first
        expect(first_package.name).to eq('A3')
        expect(first_package.title).to eq('A3: Accurate, Adaptable, and Accessible Error Metrics for Predictive Models')
      end
    end
  end
end
