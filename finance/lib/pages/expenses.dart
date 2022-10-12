import 'package:finance/utils/httpHelper.dart';
import 'package:flutter/material.dart';
import '../blocs/authBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/card.dart' show ECard;
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
    AuthBloc authBloc = context.watch<AuthBloc>();
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
                      authBloc.LogOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Finance()),
                      );
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
                      child: GridView.count(
                          crossAxisCount: 3,
                          children: authBloc.state.expenses!))
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
            onTap: (int novoItem) {
              setState(() {
                _currentScreen = novoItem;
              });
            },
          )),
    );
  }
}
