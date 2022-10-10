import 'package:flutter/material.dart';
import './pages/login.dart';
import './blocs/authBloc.dart';
import './blocs/expensesBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
     providers: [BlocProvider(create:(context) => AuthBloc('', '')), BlocProvider(create:(context) => ExpenseBloc('',''))],

    child: MaterialApp(
      title: 'Finance App',
      home: Scaffold(
        body: const Center(
          child: Finance(),
        ),
      ),
    ));
  }
}