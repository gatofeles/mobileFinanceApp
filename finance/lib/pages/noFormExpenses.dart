import 'package:finance/blocs/ExpenseBloc/expenseBloc.dart';
import 'package:finance/blocs/ExpenseBloc/expenseEvent.dart';
import 'package:finance/blocs/ExpenseBloc/monitorBloc.dart';
import 'package:finance/blocs/RestApiBloc/NewAuthBloc.dart';
import 'package:finance/blocs/RestApiBloc/authEvents.dart';
import 'package:finance/components/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/expenseForm.dart';
import '../pages/chart.dart';

class NoFormExpenses extends StatefulWidget {
  const NoFormExpenses({Key? key}) : super(key: key);

  @override
  State<NoFormExpenses> createState() => NoFormExpensesState();
}

class NoFormExpensesState extends State<NoFormExpenses> {
  int _currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    NewAuthBloc authBloc = context.watch<NewAuthBloc>();
    ExpenseBloc expenseBloc = context.watch<ExpenseBloc>();
    MonitorBloc monitor = context.watch<MonitorBloc>();
    List<ECard> expenses = monitor.state.expenseCollection!.cardList;

    return MaterialApp(
      title: 'Expenses',
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Expenses'),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      authBloc.add(LogoutEvent());
                      monitor.add(ClearForLogout());
                    },
                    child: Icon(
                      Icons.logout,
                      size: 26.0,
                    ),
                  ))
            ],
          ),
          body: IndexedStack(
            index: _currentScreen,
            children: [
              Column(
                children: [
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: FloatingActionButton(
                          child: const Icon(Icons.add_rounded),
                          onPressed: () {
                            expenseBloc.add(ShowFormEvent());
                          })),
                  Expanded(child: ListView(children: expenses)),
                ],
              ),
              Chart()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.money_sharp), label: "Expenses"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.currency_exchange), label: "Charts"),
            ],
            currentIndex: _currentScreen,
            onTap: (int novoItem) {
              setState(() {
                if (_currentScreen == 0) {
                  _currentScreen = 1;
                } else {
                  monitor.add(ClearYearSelection());
                  _currentScreen = 0;
                }
              });
            },
          )),
    );
  }
}
