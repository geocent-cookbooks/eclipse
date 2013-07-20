#
# Cookbook Name:: eclipse
# Attributes:: default
#

default['eclipse']['version'] = 'kepler'
default['eclipse']['release_code'] = 'R'
default['eclipse']['arch'] = kernel['machine'] =~ /x86_64/ ? "x86_64" : ""
default['eclipse']['suite'] = 'jee'

default['eclipse']['plugins'] = [{"http://download.eclipse.org/releases/kepler"=>"org.eclipse.egit.feature.group"},
                                 {"http://download.eclipse.org/technology/m2e/releases"=>"org.eclipse.m2e.feature.feature.group"},
                                 {"http://vrapper.sourceforge.net/update-site/stable"=>"net.sourceforge.vrapper.feature.group"}]

default['eclipse']['url'] = ''

case node['platform_family']
when "rhel", "fedora", 'debian'
  default['eclipse']['os'] = 'linux-gtk'
when "osx"
  default['eclipse']['os'] = 'macosx-cocoa'
end
