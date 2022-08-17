<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['line']});
      google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = new google.visualization.DataTable();
      data.addColumn('number', 'Day');
      data.addColumn('number', '${legend}');

      data.addRows([
    	  <%--
    	  [${visitDates[6]}, ${visitCounts[6]}],
    	  [${visitDates[5]}, ${visitCounts[5]}],
    	  [${visitDates[4]}, ${visitCounts[4]}],
    	  [${visitDates[3]}, ${visitCounts[3]}],
    	  [${visitDates[2]}, ${visitCounts[2]}],
    	  [${visitDates[1]}, ${visitCounts[1]}],
    	  [${visitDates[0]}, ${visitCounts[0]}]
    	  --%>
				<c:forEach var="i" begin="0" end="6" varStatus="st">
				  [${visitDays[6-i]}, ${visitCounts[6-i]}],
				</c:forEach>
    	  ]);

      var options = {
        chart: {
          title: '${title}',
          subtitle: '${subTitle}'
        },
        width: 800,
        height: 500,
        axes: {
          x: {
            0: {side: 'top'}
          }
        }
      };

      var chart = new google.charts.Line(document.getElementById('line_top_x'));

      chart.draw(data, google.charts.Line.convertOptions(options));
    }
  </script>
</head>
<body>
  <div id="line_top_x"></div>
</body>
</html>