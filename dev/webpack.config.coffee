module.exports =
  module:
    loaders: [
      { test: /\.vue$/, loader: "vue-loader"}
      { test: /\.html$/, loader: "html"}
      { test: /\.coffee$/, loader: "coffee-loader"}
    ]
  resolve:
    extensions: ["",".webpack.js",".web.js",".js",".coffee",".vue"]
