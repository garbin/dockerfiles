const fs = require('fs')

const config = {
  apps: []
}

module.exports = fs.readdirSync('/etc/pm2/apps').map(app => require(`./apps/${app}`)).reduce(function (result, app) {
  try {
    result.apps = result.apps.concat(app.apps)
  } catch (e) {}
  return result
}, config)
