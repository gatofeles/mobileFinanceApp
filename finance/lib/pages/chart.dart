import 'package:finance/blocs/RestApiBloc/NewAuthBloc.dart';
import 'package:finance/blocs/ExpenseBloc/expenseBloc.dart';
import 'package:finance/blocs/ExpenseBloc/expenseEvent.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/ExpenseBloc/monitorBloc.dart';

class Chart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Chart({Key? key}) : super(key: key);

  @override
  ChartState createState() => ChartState();
}

class ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    NewAuthBloc authBloc = context.watch<NewAuthBloc>();
    MonitorBloc monitorBloc = context.watch<MonitorBloc>();

    //authBloc.add(SelectYearEvent(year: authBloc.state.dropDownSelection));

    var sum = monitorBloc.OrganizeByMonth();
    List<ChartData> chartData = [
      ChartData('Jan', sum[0]),
      ChartData('Feb', sum[1]),
      ChartData('Mar', sum[2]),
      ChartData('Apr', sum[3]),
      ChartData('May', sum[4]),
      ChartData('Jun', sum[5]),
      ChartData('Jul', sum[6]),
      ChartData('Aug', sum[7]),
      ChartData('Sep', sum[8]),
      ChartData('Oct', sum[9]),
      ChartData('Nov', sum[10]),
      ChartData('Dec', sum[11]),
    ];
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        Card(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Text('Sum by month in \$'),
          ),
        )),
        DropDown(years: monitorBloc.GetYears()),
        Container(
            child: SfCircularChart(
                legend: Legend(
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.wrap,
                    position: LegendPosition.bottom),
                series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  // Radius of doughnut's inner circle
                  innerRadius: '50%',
                  dataLabelSettings:
                      DataLabelSettings(showZeroValue: false, isVisible: true)),
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

class DropDown extends StatefulWidget {
  DropDown({this.years, this.selecYear = 'Select', super.key});

  List<String>? years;
  String selecYear;
  @override
  State<DropDown> createState() => _DropDownState();
}

String dropdownValue = "Select";

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    MonitorBloc monitorBloc = context.watch<MonitorBloc>();
    return DropdownButton<String>(
      value: monitorBloc.state.year,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          monitorBloc.add(SelectYearEvent(year: dropdownValue.toString()));
        });
      },
      items: widget.years!.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text('Year: ' + value),
        );
      }).toList(),
    );
  }
}
