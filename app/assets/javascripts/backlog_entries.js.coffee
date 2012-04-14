# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#backlog_entries').sortable
    axis: 'y'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  $('.best_in_place').best_in_place()
  $('#backlog_entry_category').autocomplete
    source: $('#backlog_entry_category').data('autocomplete-source')
    minLength: 0
  $('[rel="tooltip"]').tooltip({})
      
jQuery ->
  $('.expand_desc_link').click ->
    desc = $(this).parents('.backlog_entry').find('.description')
    if desc.hasClass('in')
      desc.collapse('hide')
    else
      desc.collapse('show')
    return false
  $('#expand_all_btn').button('toggle')
  $('#expand_all_btn').click ->
    if $(this).hasClass('active')
      $('.description.in').collapse('hide')
    else
      $('.description').collapse('show')

jQuery ->
  $('#velocity').change ->
    if $.isNumeric($('#velocity').val())
      vel = Number($('#velocity').val())
      sum = 0;
      $('.backlog_entry').each ->
        sum += 1
        if sum >= vel
          $(this).append($('#waterline'))
          $('#waterline').show(200)
          return false
    else
      $('#waterline').hide(200)
    

jQuery ->
  $(window).scrollTop($('.highlight').offset().top - 58)
  $('.highlight').effect('highlight', {color: '#005d92'}, 2000)
