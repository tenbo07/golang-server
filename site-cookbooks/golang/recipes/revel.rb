script 'install_revel' do
  action :nothing
  not_if "which revel"
  interpreter 'bash'
  user 'root'
  code <<-EOF
    source /root/.bashrc
    /usr/local/bin/go get github.com/revel/revel
    /usr/local/bin/go get github.com/revel/cmd/revel
    echo 'export PATH="$PATH:$GOPATH/bin"' >> ~/.bashrc
  EOF
end
