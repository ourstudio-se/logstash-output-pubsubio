
require 'logstash/outputs/base'
require 'logstash/namespace'
require 'google/apis/pubsub_v1'
require 'base64'

class LogStash::Outputs::Pubsubio < LogStash::Outputs::Base
  config_name 'pubsubio'
  config :topic, validate: :string, required: true

  public
  def register
    @pubsub_mutex = Mutex.new
    @pubsub = Google::Apis::PubsubV1::PubsubService.new
    @pubsub.authorization = Google::Auth.get_application_default([Google::Apis::PubsubV1::AUTH_PUBSUB])
  end # def register

  public
  def multi_receive(events)
    events.map! {|event| {data: event.to_json.to_str} }
    publish_to_pubsub(events)
  end

  public
  def receive(event)
    pubsub_message = {
      data: event.to_json.to_str
    }
    publish_to_pubsub([pubsub_message])
  end # def receive

  private 
  def publish_to_pubsub(messages)
    request = Google::Apis::PubsubV1::PublishRequest.new(messages: messages)
    @logger.debug('GCE PubSub message created')
    begin
      @pubsub_mutex.synchronize do
        result = @pubsub.publish_topic(@topic, request)
        ids = result.message_ids
        @logger.debug("GCE PubSub message published to topic #{@topic}, received the following IDs: '#{ids}'")
      end
    rescue Exception => e
      @logger.error("Exception occured during publishing", :exception => e)
    end
  end # def publish_to_pubsub
end # class LogStash::Outputs::Pubsubio
