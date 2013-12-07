jQuery ->
  bootstrap_alert = (message) ->
    $('#alert-placeholder').html('<div class="alert alert-error"><a class="close" data-dismiss="alert">×</a><span>'+message+'</span></div>')

  compose_url = (term, page) ->
    Routes.api_city_streets_path(window.gon.current_city.slug, { q: { name_matches: term }, page: page })

  $("#street-select").select2
    multiple: 1,
    minimumInputLength: 1,
    query: (query) ->
      data = {}
      $.ajax
        url: compose_url(query.term, query.page)
      .done ( d ) ->
        data = results: d.streets
        query.callback(data)

  add_zero = (i) ->
    if (i < 10)
      return "0" + i
    else
      return "" + i

  get_time = () ->
    current_time = new Date()
    hours = current_time.getHours()
    minutes = current_time.getMinutes()
    add_zero(hours) + ':' + add_zero(minutes)

  set_length = (text) ->
    len = 140 - text.length

  render_streets = () ->
    location = ''
    first = true

    streets = $("#street-select").select2("data")

    (street.text for street, i in streets).join(' x ')

  render = () ->
    $('.alert').alert('close')
    text = '[' + get_time() + '] ' + $('.type .active').text()
    text += ' ' + render_streets()
    text += ' ' + $('.how').val().replace(/^\s+|\s+$/g, '') + ' #' + gon.current_city.hashtag
    $('.preview').text(text)
    $('.send_form_text').val(text)
    set_length(text)

  clear_streets = (street_name) ->
    text = $('.preview').text()

    street_name_cross = street_name + ' x '

    re = new RegExp(street_name,"g")
    re_cross = new RegExp(street_name_cross,"g")

    text = text.replace(re_cross, '')
    text = text.replace(re, '')

    $('.preview').text(text)
    $('.send_form_text').val(text)
    set_length(text)

  $('.type .btn').click (e) ->
    $('.type .btn').removeClass('active')
    $(this).toggleClass('active')
    $('.send_form_kind').val($(this).attr('data-event-kind'))
    render()
    e.preventDefault()

  $('.how').keyup (event) =>
    $('.alert').alert('close')
    render()

  $('#street-select').change (event) =>
    render()

  $('input.send').click (event) =>
    render()
    if ($('.send_form_text').val().length < 30)
      bootstrap_alert('Упс! Слишком короткое сообщение')
      return false
    if ($('.send_form_text').val().length > 140)
      bootstrap_alert('Упс! Слишком огромное сообщение')
      return false
    $('.send_form_time').val(new Date())
    return true

  $(".send-form form").ajaxError (event, request, settings) ->
    bootstrap_alert('не удалось отправить сообщение. Мы работаем над этим. Попробуйте позже')

  $(".send-form form").bind "ajax:success", (evt, data, status, xhr) ->
    $(".send-form form").fadeOut "slow", () ->
      $(this).replaceWith('<h1>Сообщение отправлено. Следующая отправка возможна через 5 минут</h1>')

