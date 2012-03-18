# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#backlog_entries').sortable
    axis: 'y'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
      
jQuery ->
  $('.best_in_place').best_in_place()
  
jQuery ->
  $('#backlog_entry_category').autocomplete
    source: $('#backlog_entry_category').data('autocomplete-source')
    minLength: 0
      
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
