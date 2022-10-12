import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/authBloc.dart';

class Chart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Chart({Key? key}) : super(key: key);

  @override
  ChartState createState() => ChartState();
}

class ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = context.watch<AuthBloc>();
    var sum = authBloc.OrganizeByMonth();
    List<ChartData> chartData = [
      ChartData('Janeiro', sum[0]),
      ChartData('Fevereiro', sum[1]),
      ChartData('Março', sum[2]),
      ChartData('Abril', sum[3]),
      ChartData('Maio', sum[4]),
      ChartData('Junho', sum[5]),
      ChartData('Julho', sum[6]),
      ChartData('Agosto', sum[7]),
      ChartData('Setembro', sum[8]),
      ChartData('Outubro', sum[9]),
      ChartData('Novembro', sum[10]),
      ChartData('Dezembro', sum[11]),
    ];

    return Scaffold(
        body: Center(
            child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Card(
            color: Colors.blue[200],
            child: Text('Soma por mês em R\$'),
          ),
        ),
        Container(
            child: SfCircularChart(
              legend: Legend(isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              position: LegendPosition.bottom),
              
              series: <CircularSeries>[
              
          DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              // Radius of doughnut's inner circle
              innerRadius: '50%',
               dataLabelSettings: DataLabelSettings(
                                    showZeroValue : false, 
                                    isVisible: true
                                )),
        ])),
      ],
    )));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
