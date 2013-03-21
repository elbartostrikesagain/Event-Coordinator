$(document).ready ->
  $("#search").click (event) ->
    name = $("#name").val()
    email = $("#email").val()
    url = document.URL.replace("#", "") + "/search?name=" + name + "&email=" + email
    $.get url, (data) ->
      searchResultsHtml(data['users'])

searchResultsHtml = (users) ->
  results = $("#result_list")
  results.html("<dt>Results</dt>")
  eventId = document.URL.split("/").slice(-2)[0]
  url = document.URL.replace("#", "")

  $.each users, (index, user) ->
    name = user['name']
    email = user['email']
    userId = user['_id']
    html = '<dd>'+name+','+email+'<a href="' + url + '/'+userId+'" data-method="put" rel="nofollow">(add)</a></dd>'
    results.append(html)