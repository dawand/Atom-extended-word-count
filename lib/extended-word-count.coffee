ExtendedWordCountView = require './extended-word-count-view'
{CompositeDisposable} = require 'atom'

module.exports = ExtendedWordCount =
  extendedWordCountView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @extendedWordCountView = new ExtendedWordCountView(state.extendedWordCountViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @extendedWordCountView.getElement(), visible: false)

    editor = atom.workspace.getActiveTextEditor()

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'extended-word-count:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'extended-word-count:highlightedToggle': => @highlightedToggle()
    @subscriptions.add editor.onDidChange => @liveUpdate()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @extendedWordCountView.destroy()

  serialize: ->
    extendedWordCountViewState: @extendedWordCountView.serialize()

  highlightedToggle: ->

    console.log 'ExtendedWordCount was highlightedToggle!'

    editor = atom.workspace.getActiveTextEditor()
    selection = editor.getSelectedText()

    if selection is ""
      @modalPanel.hide()
      return

    words = selection.split(/\s+/).length
    charswithoutspace = selection.replace(/\ /g, "")
    chars = charswithoutspace.length
    lines =selection.split(/\n/).length
    @extendedWordCountView.newMessage(words, chars, lines)
    @modalPanel.show()

  toggle: ->
    console.log 'ExtendedWordCount was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      editor = atom.workspace.getActiveTextEditor()
      words = editor.getText().split(/\s+/).length
      charswithoutspace = editor.getText().replace(/\ /g, "")
  #    console.log(charswithoutspace)
      chars = charswithoutspace.length

      lines = editor.getText().split(/\n/).length

  #    @extendedWordCountView.setCount(words)
      @extendedWordCountView.newMessage(words, chars, lines)
      @modalPanel.show()

  liveUpdate: ->
      editor = atom.workspace.getActiveTextEditor()
      words = editor.getText().split(/\s+/).length
      charswithoutspace = editor.getText().replace(/\ /g, "")
  #    console.log(charswithoutspace)
      chars = charswithoutspace.length

      lines = editor.getText().split(/\n/).length

  #    @extendedWordCountView.setCount(words)
      @extendedWordCountView.newMessage(words, chars, lines)
