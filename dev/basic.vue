<template lang="pug">
.container(style="margin:40px")
  button(@click="someToast") Toast
  button(@click="someOtherToast") Other Toast
  br
  br
  a(href="https://github.com/vue-comps/vue-overlay/blob/master/dev/basic.vue") source
</template>

<script lang="coffee">
Velocity = require "velocity-animate"
module.exports =
  mixins:[
    require("../src/mixin")
    require("vue-mixins/vue")
  ]
  data: ->
    clicks:0
  created: ->
    @Vue.component "toast2",
      template: "<div style='background-color:white;color:black' v-text='options.text'></div>"
      props:
        options:
          type: Object
    @Vue.component "toaster-transition",
      functional: true
      render: (h,c) ->
        c.data.attrs.name = "fade"
        c.data.props = {css: false}
        c.data.on = {
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
              duration: 100
              queue: false
              complete: done
            }
          leaveCancelled: (el) ->
            Velocity el, "stop"
        }
        return h "transition-group",c.data,c.children
  methods:
    someToast:  ->
      @toast({text:"test#{++@clicks}",style:{backgroundColor: "black",color:"white"}})
    someOtherToast:  ->
      @toast({text:"test#{++@clicks}",component:"toast2"})
</script>
