CollectionView = require 'chaplin/views/collection_view'
User = require 'views/user_view'

module.exports = class UsersView extends CollectionView
  className: 'users'
  listSelector: '.users-list'

  getTemplateFunction: ->
    @template

  getView: (item) ->
    new User model: item
