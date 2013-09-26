$(document).on 'ready page:load', ->
  implEditor = patchwork.getOrCreateEditor('implementation_source')
  testEditor = patchwork.getOrCreateEditor('tests')

  runTests = ->
    testResults = $('#test-results').empty()

    worker = new Worker('/assets/testRunner.js')

    worker.addEventListener 'message', (e) ->
      result = JSON.parse(e.data)

      listItem = $('<div class="list-group-item">')
        .addClass(if result.failures.length == 0 then 'success' else 'failure')
        .text(result.name)
        .appendTo(testResults)

      icon = $('<span class="pull-right">')
        .addClass(if result.failures.length == 0 then 'icon-emo-thumbsup' else 'icon-emo-cry')
        .appendTo(listItem)

    worker.addEventListener 'error', (e) ->
      alert("Error: #{e.message}")

    worker.postMessage(JSON.stringify({
      implementation: implEditor.getValue(),
      tests: testEditor.getValue()
    }))

  $('#test-button').on 'click', (e) ->
    e.preventDefault()
    runTests()
