#= require ./parse

fs = Npm.require('fs')
ASSETS_PATH = PKG.ASSETS_PATH = fs.realpathSync('.') + '/assets'




getFirstTag = (html, tag) ->
  # Look for the first occurance of the specified tag.
  regex = new RegExp("<#{ tag }.*?>.*?</#{ tag }>", 'g')
  match = html.match(regex)
  if result = match?[0]
    # Extract innerHTML.
    result = result.substr(result.indexOf('>') + 1, result.length)
    result = result.remove(new RegExp("</#{ tag }>"))
    result





toFileObject = (fullPath) ->
  html = Markdown.loadFile(fullPath)
  file =
    path: fullPath.substring(ASSETS_PATH.length, fullPath.length)
    title: getFirstTag(html, 'h1')





getFiles = (rootPath) ->
    result = []
    walk = (path) ->
        return unless fs.existsSync(path)
        for item in fs.readdirSync(path)
          fullPath = "#{ path }/#{ item }"
          stats = fs.statSync(fullPath)

          if stats.isDirectory()
            walk(fullPath) # <== RECURSION.

          else if stats.isFile()
            if fullPath.endsWith('.md')
              result.push(toFileObject(fullPath))

    walk(rootPath)
    result


# Retrieves [.md] files.
appPaths     = getFiles("#{ ASSETS_PATH }/app")
packagePaths = getFiles("#{ ASSETS_PATH }/packages")
files        = [appPaths, packagePaths].flatten()


# Store on client.
ClientSettings.set({ markdownFiles:files })

