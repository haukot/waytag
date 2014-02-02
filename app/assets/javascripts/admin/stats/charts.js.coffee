# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  myNewChart = new Chart($("#reports").get(0).getContext("2d")).Pie(gon.reports)

  myNewChart = new Chart($("#users").get(0).getContext("2d")).Pie(gon.users)
