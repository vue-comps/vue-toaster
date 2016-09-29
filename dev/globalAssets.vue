<template lang="pug">
.container
  button(@click="someToast") Toast
  a(href="https://github.com/vue-comps/vue-overlay/blob/master/dev/basic.vue") source
</template>

<script lang="coffee">
Velocity = require "velocity-animate"
module.exports =
  mixins:[
    require("../src/mixin")
    require("vue-mixins/vue")
  ]
  beforeCompile: ->
    @Vue.component "toast2",
      template: "<div v-text='options.text'></div>"
      props:
        options:
          type: Object
      beforeDestroy: ->
        @options.cb?()
    @Vue.transition "fade",
      enter: (el,done) ->
        Velocity.hook el, "scale", "0.4"
        Velocity.hook el, "translateY", "-100%"
        Velocity el, {opacity: 1,scale: 1,translateY: 0}, {
          duration: 1000
          queue: false
          complete: done
        }
      enterCancelled: (el) ->
        Velocity el, "stop"
      leave: (el,done) ->
        Velocity el, {opacity: 0,scale:0.4,translateY:"-100%"}, {
          duration: 1000
          queue: false
          complete: done
        }
      leaveCancelled: (el) ->
        Velocity el, "stop"
  data: ->
    clicks:0

  methods:
    someToast:  ->
      @toast({text:"test#{++@clicks}",component:"toast2",transition:"fade"})
</script>

<style lang="stylus">
.container > a
  position absolute
  left 250px
  top 40px
.toast
  background-color black
  color white
</style>
