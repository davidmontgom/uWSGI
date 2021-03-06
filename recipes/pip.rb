#include_recipe "python::pip"

package "python-dev" do
  action :install
end

=begin
package "python-pip" do
  action :install
end
=end

=begin
easy_install_package "pip" do
  action :upgrade
end
=end

=begin
python_pip "uwsgi" do
  version "1.9.14"
  action :install
end
=end

=begin
execute "uwsgi" do
  command "pip install uwsgi==2.0.1"
  user "root"
  action :run
  not_if {File.exists?("/usr/local/bin/uwsgi")}
end
=end



bash "install_uwsgi" do
  cwd "/usr/share"
  code <<-EOH
    #UWSGI_EMBED_PLUGINS=msgpack pip install uwsgi==2.0.5.1
    #pip install gevent==1.2
    #pip install uwsgi==2.0.15
    #UWSGI_PROFILE=gevent pip install uwsgi==2.0.1
    pip install uwsgi==2.0.17.1
  EOH
  not_if {File.exists?("/usr/local/bin/uwsgi")}
end

package "uwsgi-plugin-python" do
  action :install
end
