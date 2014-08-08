describe 'charsToHtml', ->
  it 'does not convert null/empty', ->
    expect(Markdown.charsToHtml()).to.equal undefined
    expect(Markdown.charsToHtml(null)).to.equal null
    expect(Markdown.charsToHtml('')).to.equal ''
    expect(Markdown.charsToHtml('   ')).to.equal '   '


  it 'converts "`" to "<code>"', ->
    chars = {'`':'code'}
    html = Markdown.charsToHtml('one `two`three', { map:chars })
    expect(html).to.equal 'one <code>two</code>three'


  it 'converts multiple single length chars', ->
    chars =
      '`': 'code'
      '*': 'u'
    html = Markdown.charsToHtml('one `two` *three*', { map:chars })
    expect(html).to.equal 'one <code>two</code> <u>three</u>'


  it 'does not convert opening tag with no closing tag', ->
    chars = {'`':'code'}
    html = Markdown.charsToHtml('one `two three', { map:chars })
    expect(html).to.equal 'one `two three'


  it 'does not convert cross tags', ->
    chars =
      '`': 'code'
      '*': 'i'
    html = Markdown.charsToHtml('one `two *three`', { map:chars })
    expect(html).to.equal 'one <code>two *three</code>'


  it 'converts "**" to "<strong>"', ->
    chars = {'**':'strong'}
    html = Markdown.charsToHtml('one **two**three', { map:chars })
    expect(html).to.equal 'one <strong>two</strong>three'


  it 'converts with default char-map', ->
    html = Markdown.charsToHtml('`one` *two* **three**')
    expect(html).to.equal '<code>one</code> <i>two</i> <strong>three</strong>'
