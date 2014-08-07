describe 'charsToHtml', ->
  it 'does not convert null/empty', ->
    expect(Markdown.charsToHtml()).to.equal undefined
    expect(Markdown.charsToHtml(null)).to.equal null
    expect(Markdown.charsToHtml('')).to.equal ''
    expect(Markdown.charsToHtml('   ')).to.equal '   '


  it 'converts "`" to "<code>"', ->
    charMap = {'`':'code'}
    html = Markdown.charsToHtml('one `two`three', charMap)
    expect(html).to.equal 'one <code>two</code>three'

  # it 'converts "**" to "<strong>"', ->
  #   charMap = {'**':'strong'}
  #   html = Markdown.charsToHtml('one **two**three', charMap)
  #   expect(html).to.equal 'one <strong>two</strong>three'
