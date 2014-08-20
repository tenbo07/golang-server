filename = node[:golang][:tar_url].split('/').last

remote_file "/tmp/#{filename}" do
  source node[:golang][:tar_url]
  checksum node[:golang][:tar_sha]
  owner 'root'
  group 'root'
  notifies :run, 'script[install_golang]'
end

script 'install_golang' do
  action :nothing
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOF
    tar -C /usr/local -xzf #{filename}
  EOF
end

link '/usr/local/bin/go' do
  to '/usr/local/go/bin/go'
  link_type :symbolic
  owner 'root'
  action :create
end

%w{/usr/local/gocode /usr/local/gocode/bin /usr/local/gocode/src /usr/local/gocode/pkg}.each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
  end
end

execute 'env GOPATH' do
  not_if "env | grep GOPATH"
  command 'echo "export GOPATH=/usr/local/gocode" >> ~/.bashrc'
  action :run
end
