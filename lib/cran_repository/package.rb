CranRepository::Package = Struct.new(:name, :version, :title, :description,
                                           :date_publication, :authors, :maintainer) do
  PACKAGES_FILENAME = 'PACKAGES'
  DESCRIPTION_FILENAME = 'DESCRIPTION'
  AUTHOR_REGEXP = /(.+) <(.+?)>/

  def self.list_all
    read_packages_file.map! { |p| new(p['Package'], p['Version']) }
  end

  def fetch_more_info
    package_info = package_info_from_description
    self.title = package_info['Title']
    self.description = package_info['Description']
    self.date_publication = package_info['Date/Publication']
    self.authors = package_info['Author'].split(',')
    self.maintainer = package_info['Maintainer']
    self
  end

  def maintainer_parsed
    parse_email_rfc(maintainer)
  end

  def filename
    "#{name}_#{version}.tar.gz"
  end
  
  private

  def self.read_packages_file
    Dcf.parse(packages_list_uri.read)
  end

  def self.packages_list_uri
    URI.parse(CranRepository::BASE_URI + PACKAGES_FILENAME)
  end

  def uri
    URI.parse(CranRepository::BASE_URI + filename)
  end

  def package_info_from_description
    Dcf.parse(get_description_content_from_file).first
  end

  def get_description_content_from_file
    extracted_package = Gem::Package::TarReader.new(
      Zlib::GzipReader.open(uri.open)
    )
    extracted_package.seek("#{name}/#{DESCRIPTION_FILENAME}") do |f|
      f.read
    end
  end

  def parse_email_rfc(email_rfc)
    name, email = AUTHOR_REGEXP.match(email_rfc).captures
    { name: name, email: email }
  end
end
