module CranRepository
  require 'dcf'
  require 'open-uri'
  require 'rubygems/package'
  require 'zlib'

  # Force open-uri to create tempfile.
  OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
  OpenURI::Buffer.const_set 'StringMax', 0

  BASE_URI = 'http://cran.r-project.org/src/contrib/'
end
