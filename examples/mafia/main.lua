-- Overrides package path
package.path = package.path .. ';../../?.lua'

-- Simple game declaration with config.
game = require('golem.game'):new({
  id = 'my.game.id',
  title = 'Hello World',
})

-- Start game by load `Menu` scene in `scenes` directory.
game:start('Menu')
