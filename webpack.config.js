const path = require('path');
const glob = require('glob');

const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

const outputDir = path.join(__dirname, "./lib/web/priv/");


module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new UglifyJsPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
    entry: './lib/web/assets/js/app.js',
  output: {
    filename: 'app.js',
    path: outputDir
  },
  module: {
    rules: [
      { 
        test: /\.jsx?$/, 
        loaders: ['babel'], 
        include: path.join(__dirname, 'lib/web/assets/jsx')
       },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader']
      },
      { test: /\.scss$/, loaders: [ 'style-loader', 'css-loader', 'postcss-loader', 'sass-loader' ] },
      { test: /\.png$/, loader: "url-loader?limit=100000" },
      { test: /\.jpg$/, loader: "file-loader" },
      { test: /\.(woff2?|svg)$/, loader: 'url?limit=10000' },
      { test: /\.(ttf|eot)$/, loader: 'file' },
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: './lib/web/priv/static/css/app.css' }),
    new CopyWebpackPlugin([{ from: './lib/web/priv/static/', to: outputDir }])
  ]
});