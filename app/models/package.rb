class Package < ActiveRecord::Base

  def self.create_from_repository(repo_package)
    p = Package.new
    p.name = repo_package.name
    p.version = repo_package.version
    p.title = repo_package.title
    p.description = repo_package.description
    p.date_publication = repo_package.date_publication
    p.authors = repo_package.authors

    maintainer_parsed = repo_package.maintainer_parsed
    p.maintainer_name = maintainer_parsed[:name]
    p.maintainer_email = maintainer_parsed[:email]
    p.save!
  end

  def self.necessary_to_import?(name,version)
    !Package.exists? name: name, version: version
  end
end
