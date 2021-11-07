process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

const webpack = require('webpack')
environment.plugins.prepend(
    'Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',
        Popper: ['popper.js', 'default']
    })
)
module.exports = environment.toWebpackConfig()
