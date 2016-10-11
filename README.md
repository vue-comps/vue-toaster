# vue-toaster

A fully customizable toaster.

### [Demo](https://vue-comps.github.io/vue-toaster)

- register your own toast-components with the toaster
- singleton, same instance shared by all using components

# Install

```sh
npm install --save-dev vue-toaster
// vue@1.0
npm install --save-dev vue-toaster@1
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
style | Vue Style | - | style of the toast element
cb | Function | - | will be called on close of toast

These are used in the default toast:

Name | type | default | description
---:| --- | ---| ---
text | String | - | text to display

#### Provide your own toast component

You can provide your own toast component with the help of the global Vue instance:
```js
Vue.component('toast2', {template: "<div v-text='options.text'></div>",props:["options"]})

```
You can then use it in your component:
```js
mixins: [require("vue-toaster")],
methods:{
  doToast: function() {
    @toast({text:"I'm toast",component:"toast2"})
  }
}
```

#### Provide your own toast transition
You can provide a default transition like this:
```js
// must be a transition group
// be sure to pass down the context data
Vue.component('toaster-transition', {
  functional: true
  render: function(h,context) {
    context.data.attrs.name = "fade"
    context.data.props = {css: false}
    context.data.on = {
      enter: ...
    }
    return h "transition-group",context.data,context.children)
  }
})
```

## Changelog
- 2.0.0  
now compatible with vue 2.0.0  
changed way of using own transition  

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
