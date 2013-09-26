window.fls =
  editors: {}

  getOrCreateEditor: (textarea) ->
    textarea = document.getElementById(textarea) if typeof textarea == 'string'

    fls.editors[textarea.id] ?= CodeMirror.fromTextArea(textarea, {
      mode: 'javascript',
      lineNumbers: true,
      readOnly: !!textarea.getAttribute('data-readonly')
    })

$(document).on 'ready page:load', ->
  fls.editors = {}

  $('textarea.editor').each ->
    fls.getOrCreateEditor(this)

  $('a.submit-form').on 'click', ->
    $(this).closest('form').submit()
