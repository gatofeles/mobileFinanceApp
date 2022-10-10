import 'package:flutter/material.dart';
import '../blocs/authBloc.dart';
import '../blocs/expensesBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/card.dart' show ECard;

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = context.watch<AuthBloc>();
    
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Column(
          children:[ECard(title:'Tomate',description: 'Tomato', date: '20/20/2020',value:'25')],
        ),
      ),
    );
  }
}