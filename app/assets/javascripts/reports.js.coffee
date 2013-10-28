# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  bootstrap_alert = (message) ->
    $('#alert-placeholder').html('<div class="alert alert-error"><a class="close" data-dismiss="alert">×</a><span>'+message+'</span></div>')

  compose_url = (term, page) ->
    "/api/cities/" + window.gon.current_city.sub_domain + "/streets?q[name_matches]=%25" + term + "%25" + "&page=" + page

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

    percent = parseInt((text.length / 140) * 100)
    $('.progress .bar').css('width', percent + '%') 
    $('.progress .bar').css('height', $('.progress .preview').height())

    if (len > 0 && text.length > 30) 
      $('.progress').removeClass('progress-danger')
      $('.progress').addClass('progress-success')
    else 
      $('.progress').removeClass('progress-success')
      $('.progress').addClass('progress-danger')

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
    $('.form_text').val(text)
    set_length(text)

  clear_streets = (street_name) ->
    text = $('.preview').text()

    street_name_cross = street_name + ' x '

    re = new RegExp(street_name,"g")
    re_cross = new RegExp(street_name_cross,"g")

    text = text.replace(re_cross, '')
    text = text.replace(re, '')

    $('.preview').text(text)
    $('.form_text').val(text)
    set_length(text)

  $('.type .btn').click (event) ->
    $('.type .btn').removeClass('active')
    $(this).toggleClass('active')
    render()

  $('.how').keyup (event) =>
    $('.alert').alert('close')
    render()

  $('#street-select').change (event) =>
    render()

  $('input.send').click (event) =>
    render()
    if ($('.form_text').val().length < 30)
      bootstrap_alert('Упс! Слишком короткое сообщение')
      return false
    if ($('.form_text').val().length > 140)
      bootstrap_alert('Упс! Слишком огромное сообщение')
      return false
    return true
