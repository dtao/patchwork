$(document).on 'ready page:load', ->
  signatureTemplate =
    """
    /**
     * {{{description}}}
     *
     {{#args}}
     * @param {{type}} {{name}}
     {{/args}}
     * @return {{return_type}}
     *
     * @examples
     {{#examples}}
     * {{{input}}} => {{{output}}}
     {{/examples}}
     */
    function {{{name}}}({{args_list}}) {
      // Implementation goes here
    }
    """

  debounce = (delay, fn) ->
    timeoutId = null

    return ->
      if timeoutId?
        clearTimeout(timeoutId)

      callback = ->
        fn()
        timeoutId = null

      timeoutId = setTimeout(callback, delay)

  parseArgument = (arg) ->
    parts = arg.split(':', 2)

    {
      name: parts[0],
      type: '{' + (parts[1] || '*') + '}'
    }

  parseArguments = ->
    values = $('#spec_args').val().split(/,\s*/)
    args = []
    for value in values
      if value.length > 0
        args.push(parseArgument(value))

    args

  renderSignature = ->
    editor = patchwork.getOrCreateEditor('spec_signature')

    spec =
      name: $('#spec_name').val()
      description: $('#spec_description').val()

    if !spec.name && !spec.description
      editor.setValue('')
    else
      spec.args = parseArguments()
      spec.args_list = (arg.name for arg in spec.args).join(', ')
      spec.return_type = $('#spec_return').val()
      editor.setValue(Mustache.render(signatureTemplate, spec))

  $('#spec_name').on 'change', renderSignature
  $('#spec_description').on 'change', renderSignature
  $('#spec_args').on 'change', renderSignature
  $('#spec_return').on 'change', renderSignature
