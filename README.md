# vue-toaster

A fully customizable toaster.

### [Demo](https://vue-comps.github.io/vue-toaster)

- register your own toast-components with the toaster
- singleton, same instance shared by all using components

# Install

```sh
npm install --save-dev vue-toaster
```
or include `build/bundle.js`.

## Usage

```coffee
# default is to use it as a mixin
# in your component:
mixins: [
  require("vue-toaster") # adds a method `toast(options)`
  # or with bundle.js
  window.vueComps.toaster
]
methods:
  doToast: ->
    # this will just create a `<div class="toast">{{options.text}}</div>`
    # for each toast:
    toast = @toast({text:"I'm toast"})
    toast.close() # to dismiss
    # the returned object is identical with the options argument:
    toastIn = {text:"I'm toast"}
    toastOut = @toast(toastIn)
    toastOut === toastIn # true
```

For examples see [`dev/`](dev/).

#### Options
The options object will be used in the toaster and then passed down to the toast.
These are used by the toaster:

Name | type | default | description
---:| --- | ---| ---
component | String | "toast" | Name of the component to display
timeout | Number | 2500 | time in milliseconds, when a toast will be closed automatically. The timeout will be halted on `mouseenter` and started again on `mouseleave`
class | Vue class | ["toast"] | class of the toast element
transition | String | "toast" | Vue transition to use
cb | Function | - | will be called on close of toast

These are used in the default toast:

Name | type | default | description
---:| --- | ---| ---
text | String | - | text to display

#### Provide your own toast / transition

You can provide your own toast component and transition with the help of the global Vue instance:
```js
Vue.component('toast2', {template: ...})
Vue.transition('fade', {enter: ...})
```
You can then use it in your component:
```js
mixins: [require("vue-toaster")],
methods:{
  doToast: function() {
    @toast({text:"I'm toast",component:"toast2",transition:"fade"})
  }
}
```

You can provide a default transition like this:
```js
Vue.transition('toast', {enter: ...})
```

## More than basic customize
If you want to customize without the use of the global Vue instance, you need to create a wrapper around `vue-toaster`:
```coffee
# get the Toaster constructor
Toaster = require("vue-toaster/toaster")
# change the things you want to change,
# here the default toast component is
# replaced by another one
Toaster.obj.components.toast = require("./toast")
# you could add other toasts.
# they would be activated this way:
# @toaster.toast({component:"toastWithActions",text:"something"})
Toaster.obj.components.toastWithActions = require("./toastWithAction")

# change a prop default (see below for a list)
Toaster.obj.props.timeout.default = 3000

# create a usable mixin for the new toaster
module.exports =
  computed: require("vue-mixins/vue").computed
  compiled: ->
    toaster = Toaster(@Vue)
    if toaster.used == 0
      document.body.appendChild toaster.$el
    toaster.used++
    @toast = toaster.toast
  beforeDestroy: ->
    toaster = Toaster(@Vue)
    toaster.used--
    if toaster.used == 0
      toaster.clear()
      document.body.removeChild toaster.$el

# your wrapper would the be included like this:
# mixins: [require("./wrapperForToast")]
```

Examples for toasts:
- [basic toast](src/toast.vue)
- [materialize toast](https://github.com/paulpflug/vue-materialize/tree/master/src/toast.vue)

Example for a toaster-wrapper:
- [materialize toaster](https://github.com/paulpflug/vue-materialize/tree/master/src/toaster.coffee)

Props defaults you can be changed by wrapping:

Name | type | default | description
---:| --- | ---| ---
id | String | "toast-container" | id of the toaster element
isTop | Boolean | - | when `isTop`, new toasts will be appended, otherwise prepended. This will be detected, when not set
component | String | "toast" | name of the default component to use for a toast
class | Array | function(){return ["toaster"]} | classes for the toaster element
toastClass | Array | function(){return ["toaster"]} | default classes for a toast element
zIndex | Number | 10000 | `z-index` of the toaster
timeout | Number | 2500 | default timeout for a toast

## Changelog
- 1.1.0  
toast now closes on click, can be prevented by a custom toast with `@click.prevent="onClick"`  
added vue transition  
renamed `classes` option to `class`  
properly remove toaster from dom when last using component is destroyed  

- 1.0.0  
added unit tests  

# Development
Clone repository
```sh
npm install
npm run dev
```
Browse to `http://localhost:8080/`.

## License
Copyright (c) 2016 Paul Pflugradt
Licensed under the MIT license.
