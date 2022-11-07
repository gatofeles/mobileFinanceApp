

import 'package:finance/blocs/RestApiBloc/NewAuthBloc.dart';
import 'package:finance/blocs/RestApiBloc/authEvents.dart';
import 'package:finance/blocs/SqliteBloc/expenseBloc.dart';
import 'package:finance/blocs/SqliteBloc/expenseEvent.dart';
import 'package:finance/components/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../components/expenseForm.dart';
import '../pages/chart.dart';
import '../pages/login.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => ExpensesState();
}

class ExpensesState extends State<Expenses> {
  int _currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    NewAuthBloc authBloc = context.watch<NewAuthBloc>()..add(LoadExpenses());
    ExpenseBloc expenseBloc = context.watch<ExpenseBloc>()..add(LoadExpenseEvent(userId:authBloc.state.userId));
    List<ECard> expenses = authBloc.state.useDatabase ? expenseBloc.state.expenses?? [] :authBloc.state.expenses?? [];

    CardForm cardForm =
        CardForm(token: authBloc.state.token, userId: authBloc.state.userId);
    return MaterialApp(
      title: 'Despesas',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Despesas'),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Finance()),
                      ).then((value) => setState(() {}));
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
                  cardForm,
                  Expanded(
                      child: ListView(children: expenses)),
                ],
              ),
              Chart()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.money_sharp), label: "Despesas"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.currency_exchange), label: "Gráficos"),
            ],
            currentIndex: _currentScreen,
            onTap: (int novoItem) {
              setState(() {
                if (_currentScreen == 0) {
                  _currentScreen = 1;
                } else {
                  _currentScreen = 0;
                }
              });
            },
          )),
    );
  }
}
