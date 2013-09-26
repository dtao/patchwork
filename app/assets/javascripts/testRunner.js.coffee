importScripts('jasmine.js')

getSpecFailures = (spec) ->
  resultItems = spec.results().getItems()
  failures = []
  for item in resultItems
    failures.push(item.message) if item.passed && !item.passed()
  failures

this.onmessage = (e) ->
  data = JSON.parse(e.data)

  eval(data.implementation)
  eval(data.tests)

  jasmineEnv = jasmine.getEnv()

  jasmineEnv.addReporter
    reportSpecResults: (spec) ->
      messageData =
        name: spec.getFullName()
        failures: getSpecFailures(spec)

      postMessage(JSON.stringify(messageData))

  jasmineEnv.execute()
