CollectionView = require 'chaplin/views/collection_view'
Repo = require 'views/repo_view'

module.exports = class ReposView extends CollectionView
  tagName: 'ul'
  className: 'user-repo-list'

  getView: (item) ->
    new Repo model: item
