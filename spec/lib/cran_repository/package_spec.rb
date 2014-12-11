require 'rails_helper'

describe CranRepository::Package do
  describe '.list_all' do
    before do
      packages_contents = File.read('spec/fixtures/PACKAGES')
      stub_request(:get, 'http://cran.r-project.org/src/contrib/PACKAGES').to_return(status: 200, body: packages_contents)
    end

    it 'must return array of packages' do
      packages = CranRepository::Package.list_all
      expected_array = [CranRepository::Package.new('A3','0.9.2'),
                        CranRepository::Package.new('abc','2.0'),
                        CranRepository::Package.new('abcdeFBA','0.4')]

      expect(packages).to eq(expected_array)
    end
  end
  
  describe '#fetch_more_info' do
    context 'when package is present' do
      let(:package) { CranRepository::Package.new('ALSCPC','1.0') }

      before do
        package_file = File.read('spec/fixtures/ALSCPC_1.0.tar.gz')
        stub_request(:get, 'cran.r-project.org/src/contrib/ALSCPC_1.0.tar.gz').to_return(status: 200, body: package_file)

        package.fetch_more_info
      end

      it 'expect to fetch other package infos' do
        expect(package.title).to eq('Accelerated line search algorithm for simultaneous orthogonal transformation of several positive definite symmetric matrices to nearly diagonal form.')
        expect(package.description).to eq('Using of the accelerated line search algorithm  for simultaneously diagonalize a set of symmetric positive definite matrices.')
        expect(package.date_publication).to eq('2013-09-07 13:54:56')
        expect(package.authors).to eq(['Dariush Najarzadeh'])
        expect(package.maintainer_parsed).to eq({ name: 'Dariush Najarzadeh', email: 'D_Najarzadeh@sbu.ac.ir' })
      end
    end

    context 'when package is not present on repository' do
      let(:package) { CranRepository::Package.new('ALSCPC','2.0') }

      before do
        stub_request(:get, 'cran.r-project.org/src/contrib/ALSCPC_2.0.tar.gz').to_return(status: 404, body: nil)
      end

      it { expect{ package.fetch_more_info }.to raise_error(OpenURI::HTTPError) }
    end
  end

  describe '#maintainer_parsed' do
    let(:package) { CranRepository::Package.new('package','1.0') }

    context 'when format is correct' do
      before do
        package.maintainer = 'Raphael Costa <raphael@raphaelcosta.net>'
      end

      it 'must return hash with email and name' do
        expect(package.maintainer_parsed).to eq({ name: 'Raphael Costa', email: 'raphael@raphaelcosta.net' })
      end
    end

    context 'when format is not correct' do
      before do
        package.maintainer = 'Raphael Costa'
      end

      it 'must return hash only with name' do
        expect(package.maintainer_parsed).to eq({ name: 'Raphael Costa', email: nil })
      end
    end
  end
end
