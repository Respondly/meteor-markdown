describe 'charsToHtml', ->
  it 'does not convert null/empty', ->
    console.log 'Markdown', Markdown
    expect(Markdown.charsToHtml()).to.equal undefined
    expect(Markdown.charsToHtml(null)).to.equal null
    expect(Markdown.charsToHtml('')).to.equal ''
    expect(Markdown.charsToHtml('   ')).to.equal '   '

