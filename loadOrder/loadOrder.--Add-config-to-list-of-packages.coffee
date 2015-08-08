if process.argv[2] is 'publish'
  return

writeFile        = Npm.require('fs').writeFileSync
readFile         = Npm.require('fs').readFileSync
pathResolve      = Npm.require('path').resolve
CONFIG_FULL_NAME = loadOrder.CONFIG_FULL_NAME

packagesFilepath = pathResolve('.meteor/packages')
lines = readFile(packagesFilepath, { encoding: 'utf8' }).split('\n')

if lines[lines.length - 1] is ''
  lines.pop()

if CONFIG_FULL_NAME not in lines
  writeFile(
    packagesFilepath,
    lines.concat(CONFIG_FULL_NAME).join('\n')
  )
