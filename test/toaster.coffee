env = null
toaster = null
describe "toaster", ->

  describe "basic env", ->

    before (done) ->
      env = loadComp(require("../dev/basic.vue"))
      env.$nextTick ->
        toaster = require("../src/toaster.coffee")()
        done()
    after ->
      unloadComp(env)

    it "should work", (done) ->
      env.toast({text:"test",timeout:50})
      env.$nextTick ->
        toaster.$el.childNodes.length.should.equal 1
        toast = toaster.$el.firstChild
        toast.should.have.text("test")
        toast.should.have.class("toast")
        setTimeout (->
          toaster.$el.childNodes.length.should.equal 0
          done()
          ),200

    it "should close", (done) ->
      {close} = env.toast({text:"test",timeout:5000})
      env.$nextTick ->
        toaster.$el.childNodes.length.should.equal 1
        close()
        setTimeout (->
          toaster.$el.childNodes.length.should.equal 0
          done()
          ),150
