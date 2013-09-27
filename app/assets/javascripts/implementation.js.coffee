$(document).on 'ready page:load', ->
  return if !window.location.pathname.match(/implementations\/new$/)

  implEditor = patchwork.getOrCreateEditor('implementation_source')
  testEditor = patchwork.getOrCreateEditor('tests')

  runTests = ->
    testResults = $('#test-results').empty()

    worker = new Worker('/assets/testRunner.js')
    timeout = null

    loadingItem = $('<div class="loading">')
      .appendTo(testResults)

    loadingIcon = $('<span class="icon-spin5">')
      .appendTo(loadingItem)

    worker.addEventListener 'message', (e) ->
      clearTimeout(timeout) if timeout?

      result = JSON.parse(e.data)

      if result.finished
        loadingItem.remove()
        return

      listItem = $('<div class="list-group-item">')
        .addClass(if result.failures.length == 0 then 'success' else 'failure')
        .text(result.name)
        .insertBefore(loadingItem)

      resultIcon = $('<span class="pull-right">')
        .addClass(if result.failures.length == 0 then 'icon-emo-thumbsup' else 'icon-emo-cry')
        .appendTo(listItem)

    worker.addEventListener 'error', (e) ->
      clearTimeout(timeout) if timeout?
      loadingItem.remove()
      alert("Error: #{e.message}")

    worker.postMessage(JSON.stringify({
      implementation: implEditor.getValue(),
      tests: testEditor.getValue()
    }))

    timeout = patchwork.delay 3000, ->
      worker.terminate()
      loadingItem.remove()
      alert('The worker took longer than 3 seconds.')

  $('#test-button').on 'click', (e) ->
    e.preventDefault()
    runTests()
