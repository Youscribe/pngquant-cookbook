name             "pngquant"
maintainer       "YouScribe"
maintainer_email "it@youscribe.com"
license          "Apache 2.0"
description      "Installs/Configures pngquant"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "imagemagick", "Installs pngquant package"

%w{ubuntu debian}.each do |os|
  supports os
end

depends           "build-essential"
depends           "git"