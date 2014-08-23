Markdown = {}


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
  html = Npm.require('marked')(text)

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


