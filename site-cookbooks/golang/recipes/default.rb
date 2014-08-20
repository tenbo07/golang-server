#
# Cookbook Name:: golang
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "#{cookbook_name}::git"
include_recipe "#{cookbook_name}::mercurial"
include_recipe "#{cookbook_name}::golang"
include_recipe "#{cookbook_name}::revel"
