$(document).on 'ready page:load', ->
  signatureEditor = patchwork.getOrCreateEditor('spec_signature')
  testEditor = patchwork.getOrCreateEditor('spec_tests')

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

  jasmineTemplate =
    """
    describe('{{{name}}}', function() {
      // Unit tests go here
      it('{{{description}}}', function() {
        expect(true).toEqual(false);
      });
    });
    """

  mochaTemplate =
    """
    describe('{{{name}}}', function() {
      // Unit tests go here
      it('{{{description}}}', function() {
        assert.equal(true, false);
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

  getSpecInfo = ->
    {
      name: $('#spec_name').val()
      description: $('#spec_description').val(),
    }

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
    spec = getSpecInfo()

    if !spec.name && !spec.description
      signatureEditor.setValue('')
    else
      spec.args = parseArguments()
      spec.args_list = (arg.name for arg in spec.args).join(', ')
      spec.return_type = $('#spec_return').val()
      signatureEditor.setValue(Mustache.render(signatureTemplate, spec))

  renderTests = ->
    return if startedEditingTests

    spec = getSpecInfo()

    testEditor.setValue(Mustache.render(mochaTemplate, spec))

  renderSignatureAndTests = ->
    renderSignature()
    renderTests()

  $('#spec_name').on 'change', renderSignatureAndTests
  $('#spec_description').on 'change', renderSignatureAndTests
  $('#spec_args').on 'change', renderSignature
  $('#spec_return').on 'change', renderSignature
