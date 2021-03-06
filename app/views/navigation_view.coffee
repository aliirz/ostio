View = require 'views/view'
template = require 'views/templates/navigation'

module.exports = class NavigationView extends View
  template: template
  tagName: 'nav'
  className: 'navigation'
  containerSelector: '#navigation-container'

  initialize: ->
    super
    @modelBind 'change', @render
    @subscribeEvent 'navigation:change', (attributes) =>
      @model.clear(silent: yes)
      @model.set attributes
