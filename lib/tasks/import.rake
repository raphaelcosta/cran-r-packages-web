namespace :import do
  desc "Import new CRAN R packages from repository"
  task packages: :environment do
    CranRepository::Import.call
  end
end
