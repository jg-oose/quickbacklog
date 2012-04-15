# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#backlog_entries').sortable
    axis: 'y'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
    change: (event, ui) ->
      oindex = ui.item.index()
      nindex = ui.placeholder.index()
      nindex -= 1 if (nindex > oindex)

      sum = 0
      nentries = $('.backlog_entry').slice(0, nindex) # refactor from here
      nentries.each ->
        if entry_size is null
          entry_size = 0 # TODO proper Handling of unsized entries 
        sum += $(this).data('size')
      
      $('#velocity').val(sum)


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
    else
      $('#waterline').hide(200)


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
