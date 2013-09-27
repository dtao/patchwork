importScripts('jasmine.js');

function getSpecFailures(spec) {
  var resultItems = spec.results().getItems(),
      failures = [],
      item;

  for (var i = 0; i < resultItems.length; ++i) {
    item = resultItems[i];
    if (item.passed && !item.passed()) {
      failures.push(item.message);
    }
  }

  return failures;
}

this.onmessage = function(e) {
  var data = JSON.parse(e.data);

  eval(data.implementation);
  eval(data.tests);

  var jasmineEnv = jasmine.getEnv();

  jasmineEnv.addReporter({
    reportSpecResults: function(spec) {
      var messageData = {
        name: spec.getFullName(),
        failures: getSpecFailures(spec)
      };

      postMessage(JSON.stringify(messageData));
    },

    reportSuiteResults: function() {
      postMessage(JSON.stringify({ finished: true }));
    }
  });

  jasmineEnv.execute();
};
