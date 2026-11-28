import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

Widget buildchart({double? x, double? y}) {
  //TBD
  return Placeholder(
    fallbackHeight: x! * 0.3,
    fallbackWidth: y! * 0.2,
  );
}

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Half yearly sales analysis'),
            // Enable legend
            legend: Legend(isVisible: true),
        primaryYAxis: NumericAxis(),
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
            dataSource: [
              SalesData('Mon', 15),
              SalesData('Tue', 12),
              SalesData('Wed', 11),
              SalesData('Thu', 9),
              SalesData('Fri', 16),
              SalesData('Sat', 22),
              SalesData('Sun', 34),
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,

            dataLabelSettings: DataLabelSettings(isVisible: true),
          )
        ]
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}*/