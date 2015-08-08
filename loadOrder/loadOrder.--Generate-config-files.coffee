if process.argv[2] is 'publish'
  return

pathResolve         = Npm.require('path').resolve
pathExists          = Npm.require('fs').existsSync
writeFile           = Npm.require('fs').writeFileSync
createFolderIfNone  = Npm.require('mkdirp').sync
CONFIG_PATH         = loadOrder.CONFIG_PATH
CONFIG_SHORT_NAME   = loadOrder.CONFIG_SHORT_NAME
FILES               = loadOrder.FILES

isConfigFile = (filename) ->
  return filename.indexOf(CONFIG_SHORT_NAME) >= 0

createFolderIfNone(CONFIG_PATH)

for filename, content of FILES
  filepath = pathResolve(CONFIG_PATH, filename)

  if isConfigFile(filename) and pathExists(filepath)
    continue

  writeFile(filepath, content)
