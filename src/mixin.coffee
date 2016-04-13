# out: ../mixin.js
creator = require('./toaster')
mixin = require("vue-mixins/getVue")
mixin.compiled = ->
  @toast = creator(@getVue()).toast
module.exports = mixin
