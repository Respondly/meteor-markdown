fs = Npm.require('fs')


###
Markdown parsing:

  https://github.com/chjj/marked


Code Highlighting:

  https://highlightjs.org/
  https://github.com/isagalaev/highlight.js


###
marked    = Npm.require('marked')
highlight = Npm.require('highlight.js')



marked.setOptions
  highlight: (code) ->
    highlight.highlightAuto(code).value


# ----------------------------------------------------------------------


###
Converts the given string of markdown to HTML.

@param text: A string of markdown.
@param options:
          - within: The root tag to wrap content within.
                    For example "p" or "div".
                    Default:nothing (not wrapped)

@returns string (html)
###
Markdown.toHtml = (text, options = {}) ->
  # Setup initial conditions.
  return '' if Util.isBlank(text)
  within = options.within

  # Convert to HTML.
  html = marked(text)

  # Post process the HTML.
  html = html.remove /\n$/

  unless within is 'p'
    # Strip the <p>
    html = html.remove /^<p>/
    html = html.remove /<\/p>$/

  if within? and within isnt 'p'
    html = "<#{ within }>#{ html }</#{ within }>"

  # Finish up.
  html



# ----------------------------------------------------------------------



###
Loads the specified filed and parses it as markdown.

@param path: The path to the markdown file.
@param options: See [toHtml] method.

@returns string (html)
###
Markdown.loadFile = (path, options) ->
  file = Async.runSync (done) ->
      fs.readFile path, 'utf8', (err, result) -> done(err, result)
  if file.err?
    throw new Meteor.Error(500, file.err.message)
  else
    Markdown.toHtml(file.result.toString(), options)


