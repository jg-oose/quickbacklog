# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  update_waterline = (event, ui) ->
    if ui.item.attr('id') is 'waterline'
      water_idx = ui.item.index()
      place_idx = ui.placeholder.index()
      idx = place_idx
      idx -= 1 if (place_idx > water_idx)
    else
      idx = $('#waterline').index()
  
    sum = 0
    entries = $('.backlog_entry').slice(0, idx)
    entries.each -> # TODO proper Handling of unsized entries 
      if $(this).hasClass('ui-sortable-placeholder')
        size = ui.item.data('size') # size of item being moved
      else if $(this).hasClass('ui-sortable-helper')
        size = 0 #item being moved no longer counts
      else
        size = $(this).data('size')
  
      sum += size
    
    $('#velocity').val(sum)
    $('#waterline').find('.control-group').removeClass('error')

  $('#backlog_entries').sortable
    axis: 'y'
    update: (event, ui) ->
      console.log ui
      if ui.item.attr('id') isnt 'waterline'
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
    change: update_waterline


  $('#velocity').change ->
    if $.isNumeric($(this).val())
      velocity = Number($(this).val())
      sum = 0;
      $('.backlog_entry').each ->
        entry_size = $(this).data('size')
        if entry_size is null
          entry_size = 0 # TODO proper Handling of unsized entries 
        sum += entry_size
        if sum > velocity
          $(this).before($('#waterline'))
          $('#waterline').show(200)
          $(window).scrollTop($('#waterline').offset().top + 100 - $(window).height())
          return false
      # Handle the case of everything included
      # And handle the case of nothing in
      $('#waterline').find('.control-group').removeClass('error')
    else
      $('#waterline').find('.control-group').addClass('error')


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
  if $('.highlight').length != 0
    $(window).scrollTop($('.highlight').offset().top - 58)
    $('.highlight').effect('highlight', {color: '#005d92'}, 2000)
