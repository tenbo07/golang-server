execute 'install revel' do
  not_if "ls $GOPATH/src/github.com/revel/revel/"
  command 'source ~/.bashrc && go get github.com/revel/revel'
  action :run
end

script 'install revel cmd' do
  not_if "which revel"
  interpreter 'bash'
  user 'root'
  code <<-EOF
    source ~/.bashrc
    go get github.com/revel/cmd/revel
    echo 'export PATH="$PATH:$GOPATH/bin"' >> ~/.bashrc
  EOF
end
