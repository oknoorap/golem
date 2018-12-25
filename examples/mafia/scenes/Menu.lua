local Object = require('golem.object')
local Scene = require('golem.scene')

-- New scene with black background
local MenuScene = Scene({
  props = {
    bg = {
      color = 'rgba(0, 0, 0, 1)'
    }
  },

  state = {
    image = {
      x = 0,
      y = 0
    },
    displayRect = false,
    elapsed = 0
  },

  init = function(self)
    self.image =Object.image(game.asset('mafia.jpg'), {
      size = {
        width = 200,
        height = 200
      }
    })

    self.rect = Object.rect({
      size = {
        width = 200,
        heigt = 300
      },

      bg = {
        color = 'rgba(255, 0, 0, 1)'
      },

      border = {
        color = 'rgba(0, 0, 0, 0.2)',
        width = 2
      }
    })
  end,

  enter = function(self)
    print('enter scene')
  end,

  leave = function(self)
    print('leave scene')
  end,

  ticker = function(self, elapsed)
    self.setState({
      elapsed = elapsed
    })
  end,

  input = function(self, key)
    if key == game.input.key.ENTER then
      print('scene input')
    end
  end,

  _handleImageInput = function(self, key)
    if key == game.input.key.RIGHT then
      self.setState({
        image = {
          x = self.state.image.x + 1
        }
      })
    end
  end,

  _handleImageClick = function(self, event)
    if event.type == game.input.mouse.LEFT then
      self.setState({
        displayRect = not self.state.displayRect
      })
    end
  end, 

  render = function(self, draw)
    if self.state.displayRect == false then
      draw(self.image, {
        position = {
          x = self.state.image.x,
          y = self.state.image.y
        },
  
        events = {
          oninput = self._handleImageInput,
          onclick = self._handleImageClick
        }
      })
    end

    if self.state.displayRect == true then
      draw(self.rect, {
        position = {
          x = self.state.image.x,
          y = self.state.image.y
        }
      })
    end
  end
})

return MenuScene
