# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  myNewChart = new Chart($("#by_type").get(0).getContext("2d")).Pie(gon.by_type)

  data = {
    labels : gon.by_month.labels,
    datasets : [
      {
        fillColor : "rgba(240,230,230,0.5)",
        strokeColor : "#ee684e",
        pointColor : "#ee684e",
        pointStrokeColor : "#fff",
        data : gon.by_month.data
      }
    ]
  }

  myNewChart = new Chart($("#by_month").get(0).getContext("2d")).Line(data)

  data = {
    labels : gon.by_day.labels,
    datasets : [
      {
        fillColor : "rgba(203, 243, 245,0.5)",
        strokeColor : "rgba(0, 177, 188, 0.9)",
        data : gon.by_day.data
      }
    ]
  }

  myNewChart = new Chart($("#by_day").get(0).getContext("2d")).Bar(data)

  data = {
    labels : gon.by_hour.labels,
    datasets : [
      {
        fillColor : "rgba(240,240,230,0.5)",
        strokeColor : "#ffd35b",
        pointColor : "#ffd35b",
        pointStrokeColor : "#fff",
        datasetStrokeWidth: 4,
        data : gon.by_hour.data
      }
    ]
  }

  myNewChart = new Chart($("#by_hour").get(0).getContext("2d")).Line(data)

  data = {
    labels : gon.danger_zones.labels,
    datasets : [
      {
        fillColor : "rgba(240,240,230,0.5)",
        strokeColor : "#ffd35b",
        pointColor : "#ffd35b",
        pointStrokeColor : "#fff",
        datasetStrokeWidth: 4,
        data : gon.danger_zones.data
      }
    ]
  }

  myNewChart = new Chart($("#danger_zones").get(0).getContext("2d")).Line(data)
