// out: ..
<template lang="pug">
div(
  :id="id",
  :class="classes",
  :style="{position:'fixed',zIndex:zIndex}"
  )
  component(
    :is="toast.component"
    v-for="toast in toasts",
    :options="toast",
    @close="toast.close",
    @mouseenter="toast.removeTimeout",
    @mouseleave="toast.setTimeout"
    )
</template>

<script lang="coffee">
module.exports =

  mixins: [
    require("vue-mixins/getViewportSize")
  ]

  components:
    toast: require("./toast")

  props:
    id:
      type: String
      default: "toast-container"
    isTop:
      default: null
    component:
      type: String
      default: "toast"
    classes:
      type: Array
      default: -> ["toaster"]
    toastClasses:
      type: Array
      default: -> ["toast"]
    zIndex:
      type: Number
      default: 10000
    timeout:
      type: Number
      default: 2500

  data: ->
    toasts: []

  el: -> document.createElement "div"

  beforeDestroy: ->
    document.body.removeChild @$el

  ready: ->
    unless @isTop?
      pos = @$el.getBoundingClientRect()
      vpheight = @getViewportSize().height
      @isTop = pos.top+pos.height/2 <= vpheight/2


  methods:
    toast: (options={}) ->
      options.component ?= @component
      options.timeout ?= @timeout
      options.classes ?= @toastClasses
      options.close = =>
        index = @toasts.indexOf options
        if index > -1
          @toasts.splice(index,1)
          options.removeTimeout?()
      options.setTimeout = ->
        options.removeTimeout?()
        timeoutObj = setTimeout options.close,options.timeout if options.timeout
        options.removeTimeout = ->
          clearTimeout(timeoutObj) if timeoutObj?
      options.setTimeout()
      if @isTop
        @toasts.push options
      else
        @toasts.unshift options
      return options

</script>
