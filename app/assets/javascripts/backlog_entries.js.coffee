# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  class Waterline
    constructor: ->
      @capacity = 0 # TODO get from somewhere
      @sum_above = 0
      this.setCapacity(@capacity)

    setCapacity: (new_capacity) ->
      @capacity = new_capacity
      $('#capacity').val(@capacity)
      # TODO ajax-call to save in Projekt
      
    setSumAbove: (new_sum) ->
      @sum_above = new_sum
      $('#sum_above_line').text("(" + @sum_above + ")")
      if @sum_above > @capacity
        $('#waterline').find('.control-group').addClass('error')
      else
        $('#waterline').find('.control-group').removeClass('error')

    moveTo: (new_capacity) ->
      this.setCapacity(new_capacity)

      sum = 0
      first_out_entry = null
      $('.backlog_entry').each (i, entry) =>
        entry_size = $(entry).data('size')
        if entry_size is null
          entry_size = 0 # TODO proper Handling of unsized entries 
        if (sum + entry_size) <= @capacity
          sum += entry_size
        else
          first_out_entry = entry
          return false

      this.setSumAbove(sum)
      if first_out_entry
        $(first_out_entry).before($('#waterline'))
      else
        $('.backlog_entry').last().after($('#waterline'))
      $(window).scrollTop($('#waterline').offset().top + 100 - $(window).height())
      
    beingMoved: (event, ui) ->
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
      
      if ui.item.attr('id') is 'waterline'
        this.setCapacity(sum)

      this.setSumAbove(sum)

      #$('#waterline').find('.control-group').removeClass('error')
  
  
  the_waterline = new Waterline()

  $('#capacity').change ->
    if $.isNumeric($(this).val())
      new_capacity = Number($(this).val())
      the_waterline.moveTo(new_capacity)
    else
      $('#waterline').find('.control-group').addClass('error')

  $('#backlog_entries').sortable
    axis: 'y'
    update: (event, ui) ->
      if ui.item.attr('id') isnt 'waterline'
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
    change: (event, ui) ->
      the_waterline.beingMoved(event, ui)


jQuery ->
  $('.best_in_place').best_in_place()

  $('#backlog_entry_category').autocomplete
    source: $('#backlog_entry_category').data('autocomplete-source')
    minLength: 0

  $('[rel="tooltip"]').tooltip({})

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
