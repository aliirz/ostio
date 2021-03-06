mediator = require 'mediator'
View = require 'views/view'

module.exports = class PageView extends View
  renderedSubviews: no
  containerSelector: '#content-container'

  initialize: ->
    super
    if @model or @collection
      rendered = no
      @modelBind 'change', =>
        @render() unless rendered
        rendered = yes

  getNavigationData: ->
    {}

  renderSubviews: ->
    return

  render: ->
    super
    unless @renderedSubviews
      @renderSubviews()
      @renderedSubviews = yes
    mediator.publish 'navigation:change', @getNavigationData()
