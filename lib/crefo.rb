require 'faraday'
require 'mail'
require 'nokogiri'
require 'nori'

require 'crefo/configuration'
require 'crefo/log'
require 'crefo/service'
require 'crefo/service/change_password'
require 'crefo/service/keylist'
require 'crefo/service/logon'
require 'crefo/service/mailbox_directory'
require 'crefo/service/mailbox_entry'
require 'crefo/service/report'
require 'crefo/service/search'
require 'crefo/xml/request/envelope'
require 'crefo/xml/request/body'
require 'crefo/xml/request/header'
require 'crefo/xml/request/namespaces'
require 'crefo/xml/utils/hash_to_nodes'
require 'crefo/version'

module Crefo
end
