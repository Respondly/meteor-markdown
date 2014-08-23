fs = Npm.require('fs')


Meteor.methods
  'packages/markdown/toHtml': (text, options) ->
    check(text, String)
    check(options, Match.OneOf(undefined, {}, { within:String }))
    Markdown.toHtml(text, options)



  'packages/markdown/loadFile': (path) ->
    check(path, String)
    path = INTERNAL.ASSETS_PATH + path
    file = Async.runSync (done) ->
        fs.readFile path, 'utf8', (err, result) -> done(err, result)
    if file.err?
      throw new Meteor.Error(500, file.err.message)
    else
      Markdown.toHtml(file.result.toString())

