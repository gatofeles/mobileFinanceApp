import 'package:finance/utils/httpHelper.dart';
import 'package:flutter/material.dart';
import '../blocs/authBloc.dart';
import '../blocs/expensesBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/card.dart' show ECard;
import '../components/expenseForm.dart' ;


class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => ExpensesState();
}


class ExpensesState extends State<Expenses> {

  @override
  Widget build(BuildContext context){
    AuthBloc authBloc = context.watch<AuthBloc>();
    CardForm cardForm = CardForm(token: authBloc.state.token, userId: authBloc.state.userId);
    return MaterialApp(
      title: 'Despesas',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Despesas'),
        ),
        body: Column(
          children: [cardForm ,Expanded(child: GridView.count(
          crossAxisCount: 3,
          children: authBloc.state.expenses!,
        )) ],) 
      ),
    );
  }
}
