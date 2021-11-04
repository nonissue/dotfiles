-- just setup
require('colorizer').setup()
require('tabline').setup{}

require('pears').setup(function(conf)
    conf.preset 'tag_matching'
    conf.expand_on_enter(false)
end)

require('range-highlight').setup{
    highlight = 'Visual'
}

require('go').setup{ linter = 'golint' }
