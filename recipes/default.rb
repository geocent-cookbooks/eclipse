#
# Cookbook Name:: eclipse
# Recipe:: default
#
# Copyright (C) 2016 Lonnie VanZandt
# Copyright (C) 2013 Geocent, LLC
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "ark"

# needed for Eclipse's internal SWT-based web browser
%w[ libqt5webkit5 libqtscript4-webkit libqtwebkit4 libswt-webkit-gtk-3-jni libwebkitgtk-1.0-0 libwebkitgtk-3.0-0 ].each { |pkg|

  package pkg do
    action :upgrade
  end
}

# http://download.eclipse.org/technology/epp/downloads/release/mars/R/eclipse-modeling-mars-R-linux-gtk-x86_64.tar.gz

if node['eclipse']['url'].empty?
   
  eclipse_image = [ 
    "eclipse",
    node['eclipse']['suite'],
    node['eclipse']['version'],
    node['eclipse']['release_code'],
    node['eclipse']['os'],
    node['eclipse']['arch']
  ].join('-')
      
  eclipse_url_path = [
    node['eclipse']['site'],
    node['eclipse']['version'],
    node['eclipse']['release_code']
  ].join('/')

  eclipse_url = "#{eclipse_url_path}/#{eclipse_image}.tar.gz"
      
else
  eclipse_url = node['eclipse']['url']
end

ark "eclipse" do
  url eclipse_url
  version node['eclipse']['version']
  extension "tar.gz"
  has_binaries ['eclipse']
  append_env_path true
  action :install
  
  not_if { Pathname.new( "/usr/local/bin/eclipse" ).exist? }
end

# reject out any plugin sets explicitly requested to be excluded
pluginSet =
  if ( node['eclipse'].has_key?( 'excluding' ) ) then
    node['eclipse']['plugins'].reject{ |key, value|
                node['eclipse']['excluding'].include?( key )
            }
  else
    node['eclipse']['plugins']
  end

# install all requested, not rejected, features
if not pluginSet.empty?

  featuresDir = Pathname.new( "/usr/local/eclipse-#{node['eclipse']['version']}/features" )

  pluginSet.each do |plugin_group|
    repo, givenFeats = plugin_group.first

    neededFeats = givenFeats.split(',').reject{ |p|
    
      featureXml = featuresDir.join( "**", "#{p}".sub( /\.feature\.group/, '' ) + "_*", "feature.xml" )
      
      !Pathname.glob( featureXml ).empty?
    }
    
    features = neededFeats.join(',')
    
    execute "eclipse install features(s) #{features}" do
      command "eclipse -application org.eclipse.equinox.p2.director -noSplash -repository #{repo} -installIUs #{features} -tag VagrantInstalled"
      action :run
      ignore_failure true
    end unless features.empty?
  end
end

# allow users to update the eclipse installation
execute "make eclipse area writeable" do
  command "chmod -R a+rw /usr/local/eclipse-#{node['eclipse']['version']}"
end

# add a nice font for the editors
execute "install font Source Code Pro" do
  command "git clone --depth 1 --branch release https://github.com/adobe-fonts/source-code-pro.git /opt/fonts/adobe-fonts/source-code-pro
fc-cache -f -v /opt/fonts/adobe-fonts/source-code-pro"
end

# get some customizations for Zsh
execute "install zsh scripts" do
  command "git clone --depth 1 --branch master https://github.com/robbyrussell/oh-my-zsh.git /opt/dot-oh-my-zsh"
end
