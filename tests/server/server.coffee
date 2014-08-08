describe 'toHtml (server)', ->
  it 'does not convert null/empty', ->
    expect(Markdown.toHtml()).to.equal ''
    expect(Markdown.toHtml(null)).to.equal ''
    expect(Markdown.toHtml('')).to.equal ''
    expect(Markdown.toHtml('   ')).to.equal ''


  it 'converts toHTML within a root <p>', ->
    html = Markdown.toHtml('`one` *two* **three**', within:'p')
    expect(html).to.equal '<p><code>one</code> <em>two</em> <strong>three</strong></p>'


  it 'converts toHTML without a root <p> (default)', ->
    html = Markdown.toHtml('`one` *two* **three**')
    expect(html).to.equal '<code>one</code> <em>two</em> <strong>three</strong>'
