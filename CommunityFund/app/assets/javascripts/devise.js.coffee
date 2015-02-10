# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#fancy validators for username, email and password

#every single time there is a text input, try to validate and give feedback to user

$('#signup-username').bind 'input', ->
  $(this).val() # get the current value of the input field.
  #change frowny to happy
  $("#signup-username-face").attr(".fa fa-frown-o","fa-smile-o") if this.length > 5

$('#signup-email').bind 'input', ->
  $(this).val() # get the current value of the input field.
  #change frowny to happy
  $("#signup-email-face").attr(".fa fa-frown-o","fa-smile-o")

$('#signup-password').bind 'input', ->
  $(this).val() # get the current value of the input field.
  #change frowny to happy
  $("#signup-password-face").attr(".fa fa-frown-o","fa-smile-o") if this.length > 7

$('#signup-password-confirm').bind 'input', ->
  $(this).val() # get the current value of the input field.
  #change frowny to happy
  $("#signup-password-confirm-face").attr(".fa fa-frown-o","fa-smile-o")

