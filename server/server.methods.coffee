Meteor.methods
  'packages/markdown/toHtml': (text, options) ->
    check(text, String)
    check(options, Match.OneOf(undefined, {}, { within:String }))
    Markdown.toHtml(text, options)



  'packages/markdown/loadFile': (path) ->
    check(path, String)
    Markdown.loadFile(INTERNAL.ASSETS_PATH + path)
