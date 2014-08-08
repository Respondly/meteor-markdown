###
Converts the specified character blocks within the given text to HTML.
@param text: The text to convert.
@param options:
        - map:  (optional) The map of characters to convert.
                 If not specified, default formatting chars
                 are used for `:code, **:strong, *:italic

                 Example:
                  {
                    '`': 'code'
                    '**': 'strong'
                  }

###
Markdown.charsToHtml = (text, options = {}) ->
  # Setup initial conditions.
  return text if Util.isBlank(text)
  result = []
  withinBlockChar = null
  block = null

  # Set the default char/tag mappings.
  map = options.map
  unless map
    map =
      '`':  'code'
      '**': 'strong'
      '*':  'u'


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
  html


