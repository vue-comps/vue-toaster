// out: ..
<template lang="pug">
transition-group(tag="div",
  :id="id",
  :class="cClass",
  :name="transitionName",
  :is="cTransition",
  :style="{position:'fixed',zIndex:zIndex}",
  )
  component(
    :key="toast"
    v-for="toast in toasts",
    :is="toast.component",
    :class="toast.class",
    :style="toast.style",
    @click.native="toast.close",
    :options="toast",
    @close="toast.close",
    @mouseenter.native="toast.removeTimeout",
    @mouseleave.native="toast.setTimeout"
    )
</template>

<script lang="coffee">
module.exports =

  mixins: [
    require("vue-mixins/getViewportSize")
    require("vue-mixins/vue")
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
      default: "toaster-transition"
  computed:
    cClass: -> @class
    cTransition: ->
      name = @transition
      @transitionName = "toast"
      comp = @Vue.util.resolveAsset(@$options,'components',name)
      if comp?
        @$options.components[name] = comp
        @transitionName = null
      else
        name = "transition-group"
      return name
  data: ->
    toasts: []
    transitionName: "toast"
    used: 0

  mounted: -> @$nextTick ->
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
