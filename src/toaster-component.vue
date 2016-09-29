// out: ..
<template lang="pug">
div(
  :id="id",
  :class="class",
  :style="{position:'fixed',zIndex:zIndex}"
  )
  component(
    :is="toast.component"
    v-for="toast in toasts",
    :transition="toast.transition",
    :class="toast.class",
    @click="toast.close",
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
    class:
      type: Array
      default: -> ["toaster"]
    toastClass:
      type: Array
      default: -> ["toast"]
    zIndex:
      type: Number
      default: 10000
    timeout:
      type: Number
      default: 2500
    transition:
      type: String
      default: "toast"

  data: ->
    toasts: []
    used: 0

  el: -> document.createElement "div"

  ready: ->
    unless @isTop?
      pos = @$el.getBoundingClientRect()
      vpheight = @getViewportSize().height
      @isTop = pos.top+pos.height/2 <= vpheight/2


  methods:
    clear: ->
      for toast in @toasts
        toast.transition = null
      @toasts = []
    toast: (options={}) ->
      options.component ?= @component
      options.timeout ?= @timeout
      options.class ?= @toastClass
      options.transition ?= @transition
      options.close = (e) =>
        if e?
          return if e.defaultPrevented
          e.preventDefault()
        index = @toasts.indexOf options
        if index > -1
          @toasts.splice(index,1)
          options.removeTimeout?()
          options.cb?()
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
