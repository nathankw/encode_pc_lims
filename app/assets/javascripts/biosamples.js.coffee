# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  load_biosample_term_name_selection = -> 
    if $(".biosample_type_selector").val()
      $.get "/single_cell_sortings/select_biosample_term_name", {biosample_type_selector: $(".biosample_type_selector").val()}, (responseText,status,jqXHR) ->
        #.biosample_biosample_term_name is the wrapper div.
        $(".biosample_term_name").html(responseText)

  #use event delegation (see jQuery in Action 3rd ed., p. 154 on "event delegation").
  $(document).on "change", ".biosample_type_selector", (event) -> 
    # $(document).change "#biosample_biosample_type_id", (event) -> 
    # Note that using the CoffeeScript syntax (commented-out line above) for event delegation doesn't work, as any change events (i.e. selecting a document) cause the event below to fire.
    event.stopPropagation()
    load_biosample_term_name_selection()
  load_biosample_term_name_selection()
