# out: ../mixin.js
creator = require('./toaster')
mixin = require("vue-mixins/getVue")
mixin.compiled = ->
  @toaster = creator(@getVue())
module.exports = mixin
