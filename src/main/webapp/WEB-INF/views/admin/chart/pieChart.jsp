<html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {

        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['${vo.subTitle1}', ${vo.value1}],
          ['${vo.subTitle2}', ${vo.value2}],
          ['${vo.subTitle3}', ${vo.value3}],
          ['${vo.subTitle4}', ${vo.value4}],
          ['${vo.subTitle5}', ${vo.value5}]
        ]);

        var options = {
          title: '${vo.title}'
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

        chart.draw(data, options);
      }
    </script>
  </head>
  <body>
    <div id="piechart" style="width: 900px; height: 500px;"></div>
  </body>
</html>