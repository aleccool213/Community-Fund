# validation for both project/new and project/edit

jQuery ->
  $(document).ready ->
    $("select").addClass('form-control')
    $('.checkbox').find('input').attr('checked', false)
    $('#project_completion_date_3i').val((new Date().getDate() + 7).toString())

  $('form').submit (event) ->
    debugger
    if !(valid_content($('#project_name')) && valid_content($('#project_description')) && valid_amount($("#project_target_amount")) && valid_date && valid_communities() && valid_rewards())
      event.preventDefault()
      empty_content_validator(valid_content($('#project_name')), $('#project_name'), '#name_icon', '#name_error')
      empty_content_validator(valid_content($('#project_description')), $('#project_description'), '#description_icon', '#description_error')
      money_validator(valid_amount($('#project_target_amount')), $('#project_target_amount'), '#target_amount_icon', '#target_amount_error')
      date_validator(valid_date(), '#completion_date_error')
      communities_validator(valid_communities())
      reward_validator(valid_rewards())

  $('#project_name').bind 'input', ->
    empty_content_validator(valid_content($(this)), $(this), '#name_icon', '#name_error')
    
  $('#project_description').bind 'input', ->
    empty_content_validator(valid_content($(this)), $(this), '#description_icon', '#description_error')

  $('#project_target_amount').bind 'input', ->
    money_validator(valid_amount($(this)), $(this), '#target_amount_icon', '#target_amount_error')

  $('#project_completion_date_3i, #project_completion_date_2i, #project_completion_date_1i').change ->
    date_validator(valid_date(), '#completion_date_error')

  $('.community-box').change ->
    communities_validator(valid_communities())

  valid_content = (ref) ->
    if ref.val() == ""
      return false
    else
      return true

  valid_amount = (ref) ->
    num = parseInt(ref.val())
    if (num >= 100) && (num != NaN)
      return true
    else
      return false

  valid_date =->
    day = parseInt($('#project_completion_date_3i').val())
    month = parseInt($('#project_completion_date_2i').val())
    year = parseInt($('#project_completion_date_1i').val())

    current_date = new Date()

    # apparently month is zero ordered??
    if (new Date(year, month - 1, day) < new Date(current_date.getFullYear(), current_date.getMonth(), current_date.getDate() + 7))
      return false
    else
      return true

  valid_communities =->
    if $('.communities').find('input:checked').length >= 1
      return true
    else
      return false

  valid_rewards =->
    reward_groups = $('.reward-group')

    if reward_groups == undefined
      return true
    else
      is_valid = true
      for reward in reward_groups
        do ->
          if ($(reward).find('.reward-level').val() == "") || ($(reward).find('.reward-description').val() == "")
            is_valid = false

      return is_valid

  reward_validator = (value) ->
    if value
      $('#rewards_error').addClass('hidden')
    else
      $('#rewards_error').removeClass('hidden')

  empty_content_validator = (value, ref, icon, error_text) ->
    if value
      ref.removeClass('has-error')
      $(error_text).addClass('hidden')
      field_span = ref.parent().find(icon)
      field_span.removeClass("glyphicon glyphicon-asterisk fa fa-exclamation-circle")
      field_span.addClass("fa fa-check")
    else
      ref.addClass('has-error')
      $(error_text).removeClass('hidden')
      field_span = ref.parent().find(icon)
      field_span.removeClass("glyphicon glyphicon-asterisk fa fa-check")
      field_span.addClass("fa fa-exclamation-circle")

  money_validator = (value, ref, icon, error_text) ->
    if value
      ref.removeClass('has-error')
      $(error_text).addClass('hidden')
      field_span = ref.parent().find(icon)
      field_span.removeClass("has-money-error")
      field_span.addClass("correct-money")
    else
      ref.addClass('has-error')
      $(error_text).removeClass('hidden')
      field_span = ref.parent().find(icon)
      field_span.removeClass("correct-money")
      field_span.addClass("has-money-error")

  date_validator = (value, error_text) ->
    if value
      $('#completion_date_icon').addClass('fa fa-check hidden')
      $('#completion_date_icon').removeClass('fa fa-exclamation-circle')
      $('#project_completion_date_3i, #project_completion_date_2i, #project_completion_date_1i').removeClass('has-error-select')
      $(error_text).addClass('hidden')
    else
      $('#completion_date_icon').removeClass('fa fa-check')
      $('#completion_date_icon').addClass('fa fa-exclamation-circle')
      $('#project_completion_date_3i, #project_completion_date_2i, #project_completion_date_1i').addClass('has-error-select')
      $(error_text).removeClass('hidden')

  communities_validator = (value) ->
    if value
      $('#communities_error').addClass('hidden')
    else
      $('#communities_error').removeClass('hidden')