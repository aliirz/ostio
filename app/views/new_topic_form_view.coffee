FormView = require 'views/form_view'
template = require 'views/templates/new_topic_form'
Post = require 'models/post'
SpinnerView = require 'views/spinner_view'

module.exports = class NewTopicFormView extends FormView
  template: template
  className: 'new-topic-form'
  saveEvent: 'topic:new'

  initialize: ->
    super
    @post = new Post({topic: @model})
    @delegate 'click', '.new-topic-form-toggle-fields-button', @toggleFields
    @delegate 'keyup keydown', '.new-topic-form-title', @changeTitle
    @delegate 'keyup keydown', '.new-topic-form-text', @changeText

  toggleFields: (event) =>
    @toggled = not @toggled
    @$fields = @$('.new-topic-form-fields')
    if @toggled
      $(event.currentTarget).addClass('active')
      @$fields.removeClass('hidden')
      @$fields.addClass('bounceInDown')
    else
      @$(event.currentTarget).removeClass('active')
      @$fields.addClass('bounceOutUp')

  render: ->
    super
    @$fields = @$('.new-topic-form-fields')
    @$fields.on 'webkitAnimationFrame', =>
      console.log 1488
    @$fields.on 'webkitAnimationEnd', =>
      if @toggled
        @$fields.removeClass('bounceInDown')
      else
        @$fields.removeClass('bounceOutUp')
        @$fields.addClass('hidden')

  changeTitle: (event) =>
    return unless event.currentTarget.validity.valid
    if event.metaKey and event.keyCode is 13
      @save()
    else
      @model.set(title: $(event.currentTarget).val())

  changeText: (event) =>
    return unless event.currentTarget.validity.valid
    if event.metaKey and event.keyCode is 13
      @save()
    else
      @post.set(text: $(event.currentTarget).val())

  save: (event) =>
    spinner = new SpinnerView container: @$('.submit-form')
    @model.save()
      .success (response) =>
        @post.save()
          .success (postResponse) =>
            @$('.new-topic-form-toggle-fields-button').click()
            setTimeout =>
              @publishSave response
              @trigger 'dispose'
              @dispose()
            , 300
          .error (error) =>
            console.error 'NewTopicFormView#save', error
            @model.destroy()
          .complete =>
            spinner.dispose()
      .error =>
        spinner.dispose()
