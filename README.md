# Description
- Installs and configures the Eclipse IDE
- Installs eclipse plugins

# Requirements
- java cookbook
- ark cookbook

# Platform
- Linux
- OSX

# Usage
 
- Override the eclipse version, release_code, and suite attributes to automatically
get the eclipse version URL or use the URL attribute to override and use
a static URL

# Attributes

- `default['eclipse']['version']` - Name of eclipse release, default `kepler`
- `default['eclipse']['release_code']` = Release update code (i.e. 'R',
'SR1', 'SR2'), default `R`
- `default['eclipse']['arch']` - x64_86 or blank for i586
- `default['eclipse']['suite']` - suite code (i.e. 'java', 'jee',
'cpp'), default `jee`
- `default['eclipse']['plugins']` - list of repositories and plugins to automatically
install with this eclipse deployment, default `[{"http://download.eclipse.org/releases/kepler"=>"org.eclipse.egit.feature.group"},{"http://download.eclipse.org/technology/m2e/releases"=>"org.eclipse.m2e.feature.feature.group"}, {"http://vrapper.sourceforge.net/update-site/stable"=>"net.sourceforge.vrapper.feature.group"}]`


-`default['eclipse']['url']` - override the eclipse url version
attributes above with a static URL, default `''`

# eclipse plugins
- Egit - `org.eclipse.egit`
- m2e - `org.eclipse.m2e.feature`
- Vrapper - `net.sourceforge.vwrapper`

# Other eclipse docs
- [eclipse plugins](http://help.eclipse.org/helios/index.jsp?topic=/org.eclipse.platform.doc.isv/guide/p2_director.html)

# Author

Author:: Geocent, LLC (<YOUR_EMAIL>)
