# out: ../toaster.js
toaster = null
creator = (Vue) ->
  unless toaster?
    toaster = Vue.extend(creator.obj)
    toaster = new toaster()
  return toaster
creator.obj = require('./toaster-component')

module.exports = creator
