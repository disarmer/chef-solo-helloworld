package "ruby"		#dependencies
package "postgresql"
package "nodejs"
package "rubygems"
package "rails"
package "rake"
gem_package "rake"
gem_package "multi_json"
gem_package "bundler"

package "nginx"
template "#{node.nginx.dir}/sites-available/helloworld.conf" do
	source "nginx.conf.erb"
	mode "0644"
end

# copy config to sites-enabled
nginx_site "helloworld.conf"

user "unicorn" do
	comment "Unicorn user"
	uid 1234
	home "/var/www"
	shell "/bin/sh"		#init.d script need shell
	password "*"		#disable login
end

#init script
template "/etc/init.d/unicorn" do
	source "unicorn.erb"
	mode "0755"
end

include_recipe "database::postgresql"
postgresql_connection_info = {
        :host           => '127.0.0.1',
        :port           => node['postgresql']['port'],
        :username       => 'postgres',
        :password       => node['postgresql']['password']['postgres']
}

# create a postgresql user
postgresql_database_user 'rails' do
        connection      postgresql_connection_info
        password        'rails'
        action          :create
end

# create a postgresql database
postgresql_database 'rails' do
        connection      postgresql_connection_info
        owner           'rails'
        action          :create 
end

service "nginx" do
	action :reload
end
service "postgresql" do
	action :restart
end
service "unicorn" do
	action :restart
end

