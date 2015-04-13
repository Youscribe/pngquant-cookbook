#
# Cookbook Name:: pngquant
# Recipe:: install_source
#
# Copyright 2009, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential"
include_recipe "git"

installation_dir = "/usr/local/src/pngquant"

package "libpng-dev"

configure_options = node['pngquant']['source']['configure_options']

if node['pngquant']['source']['with_lcms2']
	package "liblcms2-dev"
	configure_options << " --with-lcms2 "
end

if node['pngquant']['source']['with_openmp']
	configure_options << " --with-openmp "
end

git installation_dir do
  repository node['pngquant']['source']['repo']
  reference node['pngquant']['source']['branch']
  action :sync
  notifies :run, "bash[compile_pngquant_source]"
end

bash "compile_pngquant_source" do
  user "root"
  cwd installation_dir
  code <<-EOH
    ./configure #{configure_options}
    make &&	make install
  EOH
  action :nothing
end