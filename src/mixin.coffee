# out: ../mixin.js
creator = require('./toaster')
module.exports =
  methods:
    getVue: require("vue-mixins/getVue").methods.getVue
  compiled: ->
    @toast = creator(@getVue()).toast
