Tones Importer
==============

Some code to download all ontologies listed at the [TONES Ontology Repository](http://rpc295.cs.man.ac.uk:8080/repository/browser) and to archive them in a local git repository.

Requirements
------------

You need Ruby 2.0 and the Debian/Ubuntu packages libxslt-dev libxml2-dev (required by Nokogiri).


Installation
------------

    git clone git://github.com/ontohub/tones_importer.git
    cd tones_importer
    bundle install

Usage
-----

Download all ontologies

    ./import.sh

Now you can find the repository in ./workspace/.git
