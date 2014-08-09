Markdown.server = server = {}


###
Converts the given string of markdown to HTML on the server.
@param text: A string of markdown.
@param options:
          - within: The root tag to wrap content within.
                    For example "p" or "div".
                    Default:nothing (not wrapped)
@param callback(err, html)
###
server.toHtml = (text, options = {}, callback) ->
  if Object.isFunction(options)
    callback = options
    options  = {}
  Meteor.call 'pkg/markdown/toHtml', text, options, (err, html) -> callback?(err, html)




###
Performs basic markdown formatting on the client.
@param markdown: A string of markdown with formatting:
                  - `code`
                  - *italic*
                  - **bold**
@param options:
          - within: The root tag to wrap content within.
                    For example "p" or "div".
                    Default:nothing (not wrapped)
###
Markdown.toHtml = (text, options = {}) ->
  # Setup initial conditions.
  return '' unless Object.isString(text)
  return '' if Util.isBlank(text)
  within = options.within
  withinBlockChar = null
  block = null
  result = []

  # Set the default char/tag mappings.
  map =
    '`':  'code'
    '**': 'strong'
    '*':  'em'


  startBlock = ->
      block = []
      result.push(block)
  startBlock()

  getTag = (key, index) -> text.substring(index, index + key.length)

  toggleBlock = (char) ->
      switch withinBlockChar?
        when false # Open the block.
          startBlock()
          block.push(char)
          withinBlockChar = char

        when true # Close the block.
          block.tag = char # Store char on previous block.
          startBlock() # Start new block.
          withinBlockChar = null


  matchingTag = (index) ->
      for key, value of map
        tag = getTag(key, index)
        if key is tag
          if withinBlockChar?
            return tag if key is withinBlockChar
          else
            return tag

  # Build up the set of blocks.
  index = 0
  until index > text.length
    if tag = matchingTag(index)
      toggleBlock(tag)
      index += tag.length
    else
      block.push(text[index])
      index += 1

  # Reconstruct the final HTML from the array.
  html = ''
  for block in result
    if tag = block.tag
      text  = block.from(1).join('')
      text  = "<#{ map[tag] }>#{ text }</#{ map[tag] }>"
    else
      text = block.join('')
    html += text

  # Finish up.
  html = "<#{ within }>#{ html }</#{ within }>" if within?
  html


