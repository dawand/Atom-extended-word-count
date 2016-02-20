module.exports =
class ExtendedWordCountView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('extended-word-count')
    @flag=true

    # Create message element

  newMessage: (text, chars, lines) ->
#    console.log(" counter: #{text}")
    message = document.createElement('div')
    message.textContent = "number of words: #{text}"
    message2 = document.createElement('div')
    message2.textContent = "number of characters: #{chars}"
    message3 = document.createElement('div')
    message3.textContent = "number of lines: #{lines}"
    console.log(@flag)
    if(@flag)
      @element.appendChild(message)
      @element.appendChild(message2)
      @element.appendChild(message3)
      @flag=false
    else
      @element.children[0].textContent = message.textContent
      @element.children[1].textContent = message2.textContent
      @element.children[2].textContent = message3.textContent
  #  message.textContent = text
  #  @element.children[0].textContent = message

  setCount: (count) ->
    message.textContent = "There are #{count} words."
    @element.children[0].textContent = message
  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
