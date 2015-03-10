#
# Cookbook Name:: td-agent-config
# Attributes:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
default['td_agent_config']['sources'] = [
  {
    test_source: {
      type: 'forward',
      tag: '**',
      params: {
        port: '24224'
      }
    }
  }
]

default['td_agent_config']['matches'] = [
  {
    test_match: {
      type: 'file',
      tag: '**',
      params: {
        path: '/var/log/td-agent/forward.log'
      }
    }
  }
]

default['opsworks']['instance']['layers'] = []

default['td_agent_config']['opsworks']['layers'] = []
