Markdown.files = files = {}
hash = new ReactiveHash()



toFileObject = (file) ->
  path = file.path

  result =
    isLoaded: false
    title: file.title
    html: ->
      @load() if not @isLoaded
      hash.get(path)

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


for file in ClientSettings.get().markdownFiles
  files[file.path] = toFileObject(file)


