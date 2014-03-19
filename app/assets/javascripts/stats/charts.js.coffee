# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  myNewChart = new Chart($("#by_type").get(0).getContext("2d")).Pie(gon.by_type)

  data = {
    labels : gon.by_month.labels,
    datasets : [
      {
        fillColor : "rgba(56, 166, 201, 0.2)",
        strokeColor : "#38a6c9",
        pointColor : "#38a6c9",
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
        fillColor : "rgba(25, 187, 155,0.2)",
        strokeColor : "rgba(25, 187, 155,0.9)",
        data : gon.by_day.data
      }
    ]
  }

  myNewChart = new Chart($("#by_day").get(0).getContext("2d")).Bar(data)

  data = {
    labels : gon.by_hour.labels,
    datasets : [
      {
        fillColor : "rgba(242, 194, 133,0.2)",
        strokeColor : "#f2c285",
        pointColor : "#f2c285",
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
        fillColor : "rgba(200, 53, 57, 0.1)",
        strokeColor : "#c83539",
        pointColor : "#c83539",
        #fillColor : "rgba(25, 187, 155,0.2)",
        #strokeColor : "#19bb9b",
        #pointColor : "#19bb9b",
        pointStrokeColor : "#fff",
        datasetStrokeWidth: 4,
        data : gon.danger_zones.data
      }
    ]
  }

  myNewChart = new Chart($("#danger_zones").get(0).getContext("2d")).Line(data)
