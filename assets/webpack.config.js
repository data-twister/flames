const path = require('path');
const glob = require('glob');
const webpack = require('webpack');

const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

const ASSETS_DIR = path.resolve(__dirname, 'js');

const OUTPUT_DIR = path.join(__dirname, "../priv/static/js");

const REACT_APP = false;

if(REACT_APP == false)
{
module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new UglifyJsPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
 entry:  {
  './js/app.js': ['./js/app.js'].concat(glob.sync('./vendor/**/*.js'))
},
  output: {
    filename: 'app.js',
    path: OUTPUT_DIR
  },
  module: {
    rules: [
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
    new MiniCssExtractPlugin({ filename: '../css/app.css' }),
    new CopyWebpackPlugin([{ from: 'static/', to: OUTPUT_DIR }])
  ]
});
}else{

  module.exports = (env, options) => ({
    optimization: {
      minimizer: [
        new UglifyJsPlugin({ cache: true, parallel: true, sourceMap: false }),
        new OptimizeCSSAssetsPlugin({})
      ]
    },
    
    entry: [
      'bootstrap-loader',
      ASSETS_DIR + '/jsx/flames-frontend.jsx'
    ],
    output: {
      path: OUTPUT_DIR,
      filename: 'app.js'
    },
    module: {
      rules: [
        { 
          test: /\.jsx?$/, 
          loaders: ['babel-loader'], 
          include: path.join(__dirname, 'jsx')
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
      new MiniCssExtractPlugin({ filename: '../css/flames-frontend.css' }),
      new CopyWebpackPlugin([{ from: 'static/', to: outputDir }]),
      new webpack.ProvidePlugin({
        $: "jquery",
        jQuery: "jquery",
        "window.jQuery": "jquery"
      })
    ]
  });
}