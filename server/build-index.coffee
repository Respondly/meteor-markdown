fs = Npm.require('fs')
ASSETS_PATH = INTERNAL.ASSETS_PATH = fs.realpathSync('.') + '/assets'


getFiles = (rootPath) ->
    result = []
    walk = (path) ->
        return unless fs.existsSync(path)
        for item in fs.readdirSync(path)
          item = "#{ path }/#{ item }"
          stats = fs.statSync(item)

          if stats.isDirectory()
            walk(item) # <== RECURSION.

          else if stats.isFile()
            if item.endsWith('.md')
              item = item.substring(ASSETS_PATH.length, item.length)
              result.push(item)

    walk(rootPath)
    result


# Retrieves [.md] files.
appPaths     = getFiles("#{ ASSETS_PATH }/app")
packagePaths = getFiles("#{ ASSETS_PATH }/packages")
paths        = [appPaths, packagePaths].flatten()

# Store on client.
ClientSettings.set({ markdownPaths:paths })

