paths = ClientSettings.get().markdownPaths
Markdown.files = files = {}
hash = new ReactiveHash()



fileObject = (path) ->
  result =
    isLoaded: false
    html: -> hash.get(path)

    load: (callback) ->
      return if @isLoading
      if @isLoaded
        callback?(null, @html())
        return
      @isLoading = true
      Meteor.call 'packages/markdown/loadFile', path, (err, result) =>
          delete @isLoading
          @isLoaded = true
          hash.set(path, result)
          callback?(err, result)


for path in paths
  files[path] = fileObject(path)








