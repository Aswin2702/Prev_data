import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {

  List<double> data;
  String name;

  Graph({super.key, required this.data, required this.name});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    List<double> dt = [];
    List<int> days = [];
    final List<DataA> CharData = [];
    for(int i=1;i<=31;i++){
      days.add(i);
      dt.add(widget.data[i]);
    }

    for(int i=0;i<31;i++){
      CharData.add(DataA(dt[i], days[i]));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Graph"),),
      body: SfCartesianChart(
        title: ChartTitle(text: "${widget.name}"),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries>[
          LineSeries<DataA,double>(
            name: "${widget.name}",
              dataSource: CharData,
              xValueMapper: (DataA dt,_) => dt.dy.toDouble(),
              yValueMapper: (DataA dt,_) => dt.data,
            enableTooltip: true,
          )
        ],
        // backgroundColor: Colors.black,
        primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
      ),
    );
  }
}

class DataA{
  DataA(this.data,this.dy);
  final double data;
  final int dy;
}