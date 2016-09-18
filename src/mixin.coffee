# out: ../mixin.js
creator = require('./toaster')
module.exports =
  computed: require("vue-mixins/vue").computed
  compiled: ->
    @toast = creator(@Vue).toast
