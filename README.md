# lita-gomi

The handler which shows a collection day of garbage.

## Installation

Add lita-gomi to your Lita instance's Gemfile:

``` ruby
gem 'lita-gomi'
```

## Configuration

``` ruby
config :ical_url,    required: true # I use this site: http://gomical.net/
config :period_time, required: true # e.g. '8:30'
```

## Usage

``` ruby
route /^gomi$/,         :gomi,    help: {'gomi'         => 'Shows next collection.'}
route /^gomi refresh$/, :refresh, help: {'gomi refresh' => 'Refreshes gomi data.'}
```
