# encoding: utf-8
require "logstash/plugins/registry"
require "logstash/inputs/zeromq"
require "logstash/filters/zeromq"
require "logstash/outputs/zeromq"

LogStash::PLUGIN_REGISTRY.add(:input, "zeromq", LogStash::Inputs::ZeroMQ)
LogStash::PLUGIN_REGISTRY.add(:filter, "zeromq", LogStash::Filters::ZeroMQ)
LogStash::PLUGIN_REGISTRY.add(:output, "zeromq", LogStash::Outputs::ZeroMQ)
