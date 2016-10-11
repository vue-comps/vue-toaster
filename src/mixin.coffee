# out: ../mixin.js
creator = require('./toaster')
module.exports =
  computed: require("vue-mixins/vue").computed
  mounted: -> @$nextTick ->
    toaster = creator(@Vue)
    if toaster.used == 0
      document.body.appendChild toaster.$el
    toaster.used++
    @toast = toaster.toast
  beforeDestroy: ->
    toaster = creator(@Vue)
    toaster.used--
    if toaster.used == 0
      toaster.clear()
      document.body.removeChild toaster.$el
