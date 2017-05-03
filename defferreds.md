```
  var dfd  = $.Defferred()
  dfd.state()
```

dfd state is pending
Can change it to resolved or rejected by calling it on the objects
Callbacks you can attach to resolved
You can do dfd,done(functionCallback)
Tiy cab do dfd.fail(callback)
dfd.always(callback)


to affect state of Defferred

you can reject(args) or resolve(args)
you can check out the state and call .state

utility helpers
.pipe()
.then()
.when()


Bundling AJAX Calls
Sidebar with data from 3 diff sources
Junior level is nested ajax calls with success callback
