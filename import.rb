#!/usr/bin/env ruby

require 'pathname'
require 'rubygems'
require 'bundler/setup'
require 'mechanize'

URL       = 'http://rpc295.cs.man.ac.uk:8080/repository/browser'
BASEDIR   = Pathname.new(File.dirname(__FILE__))
WORKSPACE = BASEDIR.join("workspace")

agent   = Mechanize.new
browser = agent.get URL

browser.links_with(text: "RDF/XML").each do |link|
  href     = link.href
  params   = CGI.parse href.split("?")[1]
  ontology = params["ontology"][0]
  host     = URI.parse(ontology).host || "local"
  basename = File.basename(ontology)
  basename << '.rdf' unless basename.include?(".")
  
  print "downloading #{href} ..."
  content  = agent.get(href).body
  puts "done"

  dir = WORKSPACE.join(host)
  dir.mkpath
  File.open(dir.join(basename), "w"){|f| f << content }
end
