require 'aws-sdk'

require_relative 'config'

sqs = Aws::SQS::Client.new(
  region: REGION,
  access_key_id: ACCCESS_KEY_ID,
  secret_access_key: SECRET_ACCESS_KEY,
)

res = sqs.receive_message(
  queue_url: QUEUE_URI,
  visibility_timeout: 30,
  wait_time_seconds: 20,
)

res[:messages].each do |mes|
  puts mes.body
  sqs.delete_message(
    queue_url: QUEUE_URI,
    receipt_handle: mes[:receipt_handle],
  )
end
