window.patchwork =
  editors: {}

  getOrCreateEditor: (textarea) ->
    textarea = document.getElementById(textarea) if typeof textarea == 'string'

    patchwork.editors[textarea.id] ?= CodeMirror.fromTextArea(textarea, {
      mode: 'javascript',
      lineNumbers: true,
      readOnly: !!textarea.getAttribute('data-readonly')
    })

$(document).on 'ready page:load', ->
  patchwork.editors = {}

  $('textarea.editor').each ->
    patchwork.getOrCreateEditor(this)

  $('a.submit-form').on 'click', ->
    $(this).closest('form').submit()
