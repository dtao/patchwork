$(document).on 'ready page:load', ->
  signatureEditor = patchwork.getOrCreateEditor('function_signature')
  testEditor = patchwork.getOrCreateEditor('function_tests')

  # A flag to track whether the user has edited the tests at all,
  # in which case we don't want to clobber his/her work
  startedEditingTests = false

  testEditor.on 'keypress', ->
    startedEditingTests = true

  signatureTemplate =
    """
    /**
     * {{{description}}}
     *
     {{#args}}
     * @param {{type}} {{name}}
     {{/args}}
     * @return {{return_type}}
     */
    function {{{name}}}({{args_list}}) {
      // Implementation goes here
    }
    """

  jasmineTemplate =
    """
    describe('{{{name}}}', function() {
      it('{{{description}}}', function() {
        expect('foo').toEqual('bar');
      });
    });
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

  getFunctionInfo = ->
    {
      name: $('#function_name').val()
      description: $('#function_description').val(),
    }

  parseArgument = (arg) ->
    parts = arg.split(':', 2)

    {
      name: parts[0],
      type: '{' + (parts[1] || '*') + '}'
    }

  parseArguments = ->
    values = $('#function_args').val().split(/,\s*/)
    args = []
    for value in values
      if value.length > 0
        args.push(parseArgument(value))

    args

  renderSignature = ->
    func = getFunctionInfo()

    if !func.name && !func.description
      signatureEditor.setValue('')
    else
      func.args = parseArguments()
      func.args_list = (arg.name for arg in func.args).join(', ')
      func.return_type = $('#function_return').val()
      signatureEditor.setValue(Mustache.render(signatureTemplate, func))

  renderTests = ->
    return if startedEditingTests

    func = getFunctionInfo()

    testEditor.setValue(Mustache.render(jasmineTemplate, func))

  renderSignatureAndTests = ->
    renderSignature()
    renderTests()

  $('#function_name').on 'change', renderSignatureAndTests
  $('#function_description').on 'change', renderSignatureAndTests
  $('#function_args').on 'change', renderSignature
  $('#function_return').on 'change', renderSignature
