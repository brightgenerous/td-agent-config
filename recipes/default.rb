#
# Cookbook Name:: td-agent-config
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
if node['td_agent']['includes']

  service 'td-agent' do
      action :stop
  end

  node['td_agent_config']['sources'].each do |k, v|
    td_agent_source k do
      action :delete;
    end
  end

  node['td_agent_config']['matches'].each do |k, v|
    td_agent_match k do
      action :delete;
    end
  end

  include_recipe 'td-agent'

  service 'td-agent' do
      action :stop
  end

  td_agent_sources = lambda do |sources|
    (sources || []).each do |source|
      source.each do |key, param|
        td_agent_source key do
          param.each do |k, v|
            case k.to_s
            when 'type'
              type v
            when 'tag'
              tag v
            when 'params'
              params v
            end
          end
        end
      end
    end
  end

  td_agent_matches = lambda do |matches|
    (matches || []).each do |match|
      match.each do |key, param|
        td_agent_match key do
          param.each do |k, v|
            case k.to_s
            when 'type'
              type v
            when 'tag'
              tag v
            when 'params'
              params v
            end
          end
        end
      end
    end
  end

  extract_directories = lambda do |directory|
    node['td_agent_config'][directory] +
    node['td_agent_config']['opsworks']['layers'].flat_map do |layers|
      layers.flat_map do |layer, layer_value|
        node['opsworks']['instance']['layers'].include?(layer) ? layer_value[directory] : []
      end
    end
  end

  td_agent_sources.call extract_directories.call 'sources'
  td_agent_matches.call extract_directories.call 'matches'

  service 'td-agent' do
      action :start
  end
end
