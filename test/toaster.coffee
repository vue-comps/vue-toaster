env = null
toaster = null
describe "toaster", ->

  describe "basic env", ->

    before ->
      env = loadComp(require("../dev/basic.vue"))
      toaster = require("../src/toaster.coffee")()
    after ->
      unloadComp(env)

    it "should work", (done) ->
      env.toast({text:"test",timeout:50})
      env.$nextTick ->
        toaster.$children.length.should.equal 1
        toast = toaster.$children[0].$el
        toast.should.have.text("test")
        toast.should.have.class("toast")
        setTimeout (->
          toaster.$children.length.should.equal 0
          done()
          ),50

    it "should close", (done) ->
      {close} = env.toast({text:"test",timeout:5000})
      env.$nextTick ->
        toaster.$children.length.should.equal 1
        close()
        env.$nextTick ->
          toaster.$children.length.should.equal 0
          done()
