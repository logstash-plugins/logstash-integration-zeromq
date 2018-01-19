# encoding: utf-8
require_relative "../spec_helper"
require "logstash/plugin"
require "logstash/event"
require "securerandom"

def send_mock_messages(messages, &block)
  socket = double("socket")
  allow(socket).to receive(:close)
  expect(socket).to receive(:recv_strings) do |arr|
    messages.each do |msg|
      msg.each do |frame|
        arr << frame
      end
    end
    0
  end
  subject.instance_variable_set(:@zsocket, socket)
  q = []
  subject.send(:handle_message, q)
  q
end

describe LogStash::Inputs::ZeroMQ do

  let(:config) { { "topology" => "pushpull" } }
  subject { described_class.new(config) }

  context "when interrupting the plugin" do
    it_behaves_like "an interruptible input plugin"
  end

  context "pubsub" do
    let(:topic_field) { SecureRandom.hex }
    let(:config) { { "topology" => "pubsub", "topic_field" => topic_field} }

    before(:each) { subject.register }
    after(:each) { subject.stop }

    it "should set the topic field with multiple message frames" do
      events = send_mock_messages([["topic", '{"message": "message"}', '{"message": "message2"}']])
      expect(events.first.get(topic_field)).to eq("topic")
      expect(events.first.get("message")).to eq("message")
      expect(events[1].get("message")).to eq("message2")
      expect(events[1].get(topic_field)).to eq("topic")
      expect(events.length).to eq(2)
    end
  end

  context "pushpull" do
    let(:config) { {"topology" => "pushpull"} }

    before(:each) { subject.register }
    after(:each) { subject.stop }

    it "should receive multiple frames" do
      events = send_mock_messages([['{"message": "message"}', '{"message": "message2"}']])
      expect(events.first.get("message")).to eq("message")
      expect(events[1].get("message")).to eq("message2")
      expect(events.length).to eq(2)
    end
  end
end
