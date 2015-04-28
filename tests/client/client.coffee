describe 'toHtml (client)', ->
  it 'does not convert null/empty', ->
    expect(Markdown.toHtml()).to.equal ''
    expect(Markdown.toHtml(null)).to.equal ''
    expect(Markdown.toHtml('')).to.equal ''
    expect(Markdown.toHtml('   ')).to.equal ''

  it 'does not convert non-string values', ->
    expect(Markdown.toHtml(true)).to.equal ''
    expect(Markdown.toHtml(1234)).to.equal ''
    expect(Markdown.toHtml({})).to.equal ''


  it 'converts "`" to "<code>"', ->
    html = Markdown.toHtml('one `two`three')
    expect(html).to.equal 'one <code>two</code>three'


  it 'converts multiple single length chars', ->
    html = Markdown.toHtml('one `two` *three*')
    expect(html).to.equal 'one <code>two</code> <em>three</em>'


  it 'does not convert opening tag with no closing tag', ->
    html = Markdown.toHtml('one `two three')
    expect(html).to.equal 'one `two three'


  it 'does not convert cross tags', ->
    html = Markdown.toHtml('one `two *three`')
    expect(html).to.equal 'one <code>two *three</code>'


  it 'converts "**" to "<strong>"', ->
    html = Markdown.toHtml('one **two**three')
    expect(html).to.equal 'one <strong>two</strong>three'


  it 'converts code, italic, bold', ->
    html = Markdown.toHtml('`one` *two* **three**')
    expect(html).to.equal '<code>one</code> <em>two</em> <strong>three</strong>'

  it 'converts toHTML within a root <p>', ->
    html = Markdown.toHtml('`one` *two* **three**', within:'p')
    expect(html).to.equal '<p><code>one</code> <em>two</em> <strong>three</strong></p>'


  it 'converts double-quotes', ->
    html = Markdown.toHtml('foo "bar" "baz')
    expect(html).to.equal 'foo “bar” "baz'


# ----------------------------------------------------------------------


describe 'toHtml (client => server)', ->
  it 'convert HTML to string', (done) ->
    markdown = '`one` two'
    Markdown.server.toHtml markdown, (err, html) =>
      done(err) if err
      expect(html).to.equal '<code>one</code> two'
      done()


  it 'convert HTML to string within a root <p>', (done) ->
    markdown = '`one` two'
    Markdown.server.toHtml markdown, { within:'p' }, (err, html) =>
      expect(html).to.equal '<p><code>one</code> two</p>'
      done()
