import 'package:finance/utils/httpHelper.dart';
import 'package:flutter/material.dart';
import '../blocs/authBloc.dart';
import '../blocs/expensesBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/card.dart' show ECard;
import '../components/expenseForm.dart' ;

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = context.watch<AuthBloc>();
    List<ECard> expenses = [];
    authBloc.state.expenses!.forEach((expense) {
      expenses.add(ECard(card: expense));
    });
    return MaterialApp(
      title: 'Despesas',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Despesas'),
        ),
        body: Column(
          children: [CardForm() ,Expanded(child: GridView.count(
          crossAxisCount: 3,
          children: expenses,
        )) ],) 
      ),
    );
  }
}
