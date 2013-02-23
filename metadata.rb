name             "hubot"
maintainer       "Seth Chisamore"
maintainer_email "schisamo@opscode.com"
license          "Apache 2.0"
description      "Deploys and manages an instance of Github's Hubot."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.3"

supports "ubuntu", ">= 10.04"
supports "centos", ">= 6.0"

depends "git"
depends "nodejs"
depends "runit"
