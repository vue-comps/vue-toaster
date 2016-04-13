// out: ..
<template lang="jade">
div(:class="options.classes") {{options.text}}
</template>

<script lang="coffee">
module.exports =
  props:
    options:
      type: Object
  beforeDestroy: ->
    options.cb?()
</script>
