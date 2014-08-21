%w{/usr/local/gocode /usr/local/gocode/bin /usr/local/gocode/src /usr/local/gocode/pkg}.each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode '0777'
    recursive true
    action :create
  end
end

filename = node[:golang][:tar_url].split('/').last

remote_file "/tmp/#{filename}" do
  source node[:golang][:tar_url]
  checksum node[:golang][:tar_sha]
  owner 'root'
  group 'root'
  notifies :run, 'script[install_golang]'
  notifies :create, 'link[/usr/local/bin/go]'
  notifies :run, 'execute[env_GOPATH]'
  notifies :run, 'script[install_revel]'
end

script 'install_golang' do
  action :nothing
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOF
    tar -C /usr/local -xzf #{filename}
    echo "export GOPATH=/usr/local/gocode" >> ~/.bashrc
    export GOPATH=/usr/local/gocode" >> /home/ec2-user/.bashrc
    chmod 755 /etc/sudoers
  EOF
end

link '/usr/local/bin/go' do
  to '/usr/local/go/bin/go'
  link_type :symbolic
  owner 'root'
  action :nothing
end


execute 'env_GOPATH' do
  not_if "env | grep GOPATH"
  command 'echo "export GOPATH=/usr/local/gocode" >> ~/.bashrc'
  action :nothing
end

template "/etc/sudoers" do
  source 'sudoers.erb'
  owner 'root'
  group 'root'
  mode '0400'
end