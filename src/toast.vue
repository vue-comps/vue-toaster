// out: ..
<template lang="pug">
div(v-text="options.text")
</template>

<script lang="coffee">
module.exports =
  props:
    options:
      type: Object
</script>
