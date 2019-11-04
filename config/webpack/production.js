process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

config.assets.digest = true

config.assets.compile = true

config.assets.js_compressor = Uglifier.new(harmony: true)
