<template lang="pug">
.container
  button(@click="someToast") Toast
  a(href="https://github.com/vue-comps/vue-overlay/blob/master/dev/basic.vue") source
</template>

<script lang="coffee">
module.exports =
  mixins:[
    require("../src/mixin")
  ]
  data: ->
    clicks:0

  methods:
    someToast:  ->
      @toast({text:"test#{++@clicks}"})
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
