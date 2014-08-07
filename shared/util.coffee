


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

  startBlock = ->
      block = []
      result.push(block)
  startBlock()

  toggleBlock = (char) ->
      switch withinBlockChar?
        when false # Open the block.
          startBlock()
          block.push(char)
          withinBlockChar = char

        when true # Close the block.
          block.char = char # Store char on previous block.
          startBlock() # Start new block.
          withinBlockChar = null


  isMatch = (char, index) ->
    for key, value of map
      if key is char
        if withinBlockChar?
          return true if key is withinBlockChar
        else
          return true
    false

  # Build the array(s) of blocks.
  for char, i in text
    if isMatch(char, i)
      toggleBlock(char)
    else
      block.push(char)

  # Reconstruct the final HTML from the array.
  html = ''
  for block in result
    if char = block.char
      text  = block.from(char.length).join('')
      tag   = map[char]
      text  = "<#{ tag }>#{ text }</#{ tag }>"
    else
      text = block.join('')
    html += text

    console.log 'block', block

  # Finish up.
  html


