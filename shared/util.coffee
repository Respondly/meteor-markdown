


###
Converts the specified character blocks within the given text to HTML.
@param text: The text to convert.
@param characterMap: (optional) The map of characters to convert.
                     If not specified, default formatting chars
                     are used for `:code, **:strong




###
Markdown.charsToHtml = (text, characterMap = {}) ->
  return text if Util.isBlank(text)