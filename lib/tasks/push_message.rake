namespace :push_message do
  desc 'LINE pushメッセージの送信'
  task notification: :environment do
    tasks = Task.where('date = ? and done_at IS NULL', Date.current)
    tasks.each do |task|
      next if task.user.notification_time.hour != Time.current.hour

      message_body = "こんにちは！今日は#{task.schedule.variety.name}(#{task.schedule.name})の「#{task.name}(#{task.plan_memo})」の作業日です！"
      message_body << "作業が終わったら https://gardenscheduler.com/tasks/#{task.id}/edit から作業記録をつけてください。"
      message = {
        type: 'text',
        text: message_body
      }
      client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV['LINE_CHANNEL_SECRET']
        config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      }
      response = client.push_message(task.user.uid, message)
      p response
    end
  end
end
