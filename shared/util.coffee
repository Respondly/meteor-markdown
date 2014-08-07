


###
Converts the specified character blocks within the given text to HTML.
@param text: The text to convert.
@param charMap: (optional) The map of characters to convert.
                     If not specified, default formatting chars
                     are used for `:code, **:strong, *:italic

                     Example:
                      {
                        '`': 'code'
                        '**': 'strong'
                      }

###
Markdown.charsToHtml = (text, charMap = {}) ->
  return text if Util.isBlank(text)

  console.log 'text', text

  # for key, value of character-map.
  charsToHtml(text, '`', 'code')





charsToHtml = (text, char, tag) ->
  return text unless text.indexOf(char) > -1
  result = []
  withinBlock = false
  block = null

  startBlock = ->
      block = []
      result.push(block)
  startBlock()

  convertTag = ->
      switch withinBlock
        when true
          block.push("</#{ tag }>")
          startBlock()
          withinBlock = false

        when false
          startBlock()
          block.push("<#{ tag }>")
          withinBlock = true

  for item, i in text
    if item is char then convertTag() else block.push(item)


  console.log 'result', result
  for item in result
    console.log 'item', item
  console.log ''

  # Finish up.
  result.flatten().join('')

