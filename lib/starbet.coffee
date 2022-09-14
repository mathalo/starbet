StarbetView = require './starbet-view'
{CompositeDisposable} = require 'atom'

module.exports = Starbet =
  starbetView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @starbetView = new StarbetView(state.starbetViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @starbetView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'starbet:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @starbetView.destroy()

  serialize: ->
    starbetViewState: @starbetView.serialize()

  toggle: ->
    console.log 'Starbet was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
