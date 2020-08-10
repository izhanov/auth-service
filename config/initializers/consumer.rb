channel = RabbitMq::Connection.consumer_channel
exchange = channel.default_exchange

queue = channel.queue("authentication", durable: true)

queue.subscribe do |deleviry_info, properties, payload|
  token = JSON.parse(payload).dig("token")
  puts token
  operation = Operations::UserSessions::Authenticate.new
  session = operation.call(token)

  if session.success?
    exchange.publish(
      { user_id: session.value!.user_id }.to_json,
      routing_key: properties.reply_to,
      correlation_id: properties.correlation_id
    )
  else
    exchange.publish(
      { error: I18n.t("sessions.token.invalid") }.to_json,
      routing_key: properties.reply_to,
      correlation_id: properties.correlation_id
    )
  end
end
