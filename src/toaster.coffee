# out: ../toaster.js
toaster = null
creator = (Vue) ->
  unless toaster?
    toaster = Vue.extend(creator.obj)
    toaster = new toaster()
    document.body.appendChild toaster.$el
  return toaster
creator.obj = require('./toaster-component')

module.exports = creator
