const path = require('path');
const mode = require('glob');
const webpack = require('webpack');

const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

const ASSETS_DIR = path.resolve(__dirname, './lib/web/assets/');

const OUTPUT_DIR = path.join(__dirname, "./priv/");

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
 entry: ASSETS_DIR +  '/js/app.js',
  output: {
    filename: 'app.js',
    path: OUTPUT_DIR
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
    new CopyWebpackPlugin([{ from: './lib/web/priv/static/', to: OUTPUT_DIR }])
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
      filename: 'flames-frontend.js'
    },
    plugins: [
      new MiniCssExtractPlugin({ filename: '/css/flames-frontend.css' }),
      new CopyWebpackPlugin([{ from: './lib/web/priv/static/', to: outputDir }]),
      new webpack.ProvidePlugin({
        $: "jquery",
        jQuery: "jquery",
        "window.jQuery": "jquery"
      })
    ]
  });
}