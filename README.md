# vue-toaster

A fully customizable toaster, with sane defaults.

### [Demo](https://vue-comps.github.io/vue-toaster)

# Install

```sh
npm install --save-dev vue-toaster
```
or include `build/bundle.js`.

## Usage

```coffee
# toaster is a singleton and is designed
# to be used in different places simultaniously
# default is to use it as a mixin
# in your component:
mixins: [
  require("vue-toaster")
  # or with bundle.js
  window.vueComps.toaster
]
methods:
  toast: ->
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
The options object will be passed down to the toast.
These are used by the toaster:

| Name | type | default | description |
| ---:| --- | ---| --- |
| component | String | "toast" | Name of the component to display |
| timeout | Number | 2500 | time in milliseconds, when a toast will be closed automatically. The timeout will be halted on `mouseenter` and started again on `mouseleave` |

These are used in the default toast:

| Name | type | default | description |
| ---:| --- | ---| --- |
| text | String | - | text to display |
| classes | Array | ["toast"] | classes of the toast element |
| cb | Function | - | will be called on close of toast |

#### Customize
For customization, you need to create a wrapper around `vue-toaster`:
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
  methods:
    getVue: require("vue-mixins/getVue").methods.getVue
  compiled: ->
    @toast = Toaster(@getVue()).toast

# your wrapper would the be included like this:
# mixins: [require("./wrapperForToast")]
```

Examples for toasts:
- [basic toast](src/toast.vue)
- [materialize toast](https://github.com/paulpflug/vue-materialize/tree/master/src/toast.vue)

Example for a toaster-wrapper:
- [materialize toaster](https://github.com/paulpflug/vue-materialize/tree/master/src/toaster.coffee)

Props defaults you can be changed by wrapping:

| Name | type | default | description |
| ---:| --- | ---| --- |
| id | String | "toast-container" | id of the toaster element |
| isTop | Boolean | - | when `isTop`, new toasts will be appended, otherwise prepended. This will be detected, when not set |
| component | String | "toast" | name of the default component to use for a toast |
| classes | Array | function(){return ["toaster"]} | classes for the toaster element |
| toastClasses | Array | function(){return ["toaster"]} | default classes for a toast element |
| zIndex | Number | 10000 | `z-index` of the toaster |
| timeout | Number | 2500 | default timeout for a toast |

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
