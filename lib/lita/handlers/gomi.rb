require 'icalendar'
require 'open-uri'
require 'time'

module Lita
  module Handlers
    class Gomi < Handler
      config :ical_url,    required: true # I use this site: http://gomical.net/
      config :period_time, required: true # e.g. '8:30'

      route /^gomi$/,         :gomi,    help: {'gomi'         => 'Shows next collection.'}
      route /^gomi refresh$/, :refresh, help: {'gomi refresh' => 'Refreshes gomi data.'}

      def gomi(response)
        event = next_collection

        response.reply ":recycle: #{event.dtstart.strftime('%m/%d')} #{event.summary}"
      end

      def refresh(response)
        redis.set :ical, open(config.ical_url).read

        response.reply ':recycle:'
      end

      def next_collection
        calendar = Icalendar.parse(redis.get(:ical)).first

        calendar.events.sort_by(&:dtstart).find {|event|
          event.dtstart >= collection_date
        }
      end

      def collection_date
        period = Time.parse(config.period_time)

        Time.now < period ? Date.today : Date.today.succ
      end
    end

    Lita.register_handler Gomi
  end
end
