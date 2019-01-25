var webpack = require('webpack');
var path = require('path');

var parentDir = path.join(__dirname, '../');


module.exports = {
	mode: 'development',
	entry: [
		path.join(__dirname, '../index.js')
	],
	module: {
		rules: [{
			test: /\.(js|jsx)$/,
			exclude: /node_modules/,
			loader: 'babel-loader'
		},
		{
			test: /\.(sass|scss)$/,
			use: [
				"style-loader", // creates style nodes from JS strings
				"css-loader", // translates CSS into CommonJS
				{
					loader: "sass-loader",
					options: {
						implementation: require("sass")
					}
				}
			]
		}
		]
	},
	output: {
		path: __dirname + '/../',
		filename: 'bundle.js'
	},
	devServer: {
		contentBase: parentDir,
		historyApiFallback: true
	}
}

