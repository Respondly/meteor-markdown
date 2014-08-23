handler = (compileStep) ->
  compileStep.addAsset
    path: compileStep.inputPath
    data: compileStep.read()


# ----------------------------------------------------------------------


Plugin.registerSourceHandler('md', handler)
