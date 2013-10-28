# Reference jQuery
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend
  # Change pluginName to your plugin's name.
  waytag: (options) ->
    # Default settings
    settings =
      limit: 5
      city: "ul"
      domain: "waytag.ru"
      debug: false

    h = () =>
      return $("<h3/>")

    ul = () =>
      return $("<ul/>")

    li = () =>
      return $("<li/>")

    div = () =>
      return $("<div/>")

    a = (href, text) =>
      return "<a href=\"#{href}\" target=\"_blank\" rel=\"nofollow\">#{text}</a>"

    # Merge default settings with options.
    settings = $.extend settings, options

    # Simple logger.
    log = (msg) ->
      console?.log msg if settings.debug

    # _Insert magic here._
    return @each ()->
      $header = h().html('Сейчас на дорогах')

      $(this).append($header)

      $list = ul()
      $list.insertAfter($header)

      render = (text) ->
        text = text.replace /(http:\/\/[A-Za-z0-9\/\.]+)/, ($1) ->
          a($1, $1)

        text = text.replace /(#([A-Za-z0-9]+))/, ($0, $1, $2) ->
          a("https://twitter.com/search?q=#{$2}", $1)

        text.replace /(@([A-Za-z0-9]+))/, ($0, $1, $2) ->
          a("https://twitter.com/#{$2}", $1)

      insertStatuses = (statuses) ->
        for status in statuses
          do (status) ->
            $li = li().html(render(status.text))
            $list.append($li)

      loadStatuses = () ->
        $.getJSON "http://#{settings.domain}/api/cities/#{settings.city}/tweets?per_page=#{settings.limit}&callback=?", (statuses) ->
          insertStatuses(statuses.tweets)

      loadStatuses()


