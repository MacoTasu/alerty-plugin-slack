require 'alerty'
require 'slack-notifier'

class Alerty
  class Plugin
    class Slack
      def initialize(config)
        raise ConfigError.new('slack: webhook_url is not configured') unless config.webhook_url

        username = config.username || 'alerty'
        timeout = config.http_options.open_timeout || 10

        @client =  ::Slack::Notifier.new config.webhook_url, username: username,
                                                             http_options: { open_timeout: timeout }
        @icon_emoji = config.icon_emoji if config.icon_emoji
        @num_retries = config.num_retries || 3
        @subject = config.subject
      end

      def alert(record)
        subject = expand_placeholder(@subject, record)
        retries = 0

        begin
          fatal_note = {
            fallback: "#{subject}",
            pretext: "#{subject}",
            text: "#{record[:output]}",
            color: "danger",
          }

          @client.ping attachments: [fatal_note], icon_emoji: @icon_emoji
        rescue => e
          retries += 1
          sleep 1
          if retries <= @num_retries
            retry
          else
            raise e
          end
        end
      end

      def expand_placeholder(str, record)
        str.gsub('${command}', record[:command]).gsub('${hostname}', record[:hostname])
      end

    end
  end
end
