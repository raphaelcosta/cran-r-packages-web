class CranRepository::Import
  def self.call
    packages = CranRepository::Package.list_all

    packages.each do |package|
      next unless ::Package.necessary_to_import? package.name, package.version

      package.fetch_more_info
      Package.create_from_repository(package)
    end
  end
end
