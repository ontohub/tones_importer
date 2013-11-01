#!/usr/bin/env ruby

require 'pathname'
require 'rubygems'
require 'bundler/setup'
require 'mechanize'

BASEDIR   = Pathname.new(File.dirname(__FILE__))
WORKSPACE = BASEDIR.join("workspace")

agent   = Mechanize.new
browser = agent.get 'http://rpc295.cs.man.ac.uk:8080/repository/browser'

browser.links_with(text: "RDF/XML").each do |link|
  href     = link.href
  params   = CGI.parse href.split("?")[1]
  ontology = params["ontology"][0]
  host     = URI.parse(ontology).host || "local"
  basename = File.basename(ontology)
  
  print "downloading #{href} ..."
  content  = agent.get(href).body
  puts "done"

  dir = WORKSPACE.join(host)
  dir.mkpath
  File.open(dir.join(basename), "w"){|f| f << content }
end
