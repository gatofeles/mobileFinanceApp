import 'package:finance/blocs/RestApiBloc/NewAuthBloc.dart';
import 'package:finance/blocs/RestApiBloc/authEvents.dart';
import 'package:finance/blocs/SqliteBloc/expenseBloc.dart';
import 'package:flutter/material.dart';
import './pages/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NewAuthBloc>(
              create: (BuildContext context) => NewAuthBloc()),
          BlocProvider<ExpenseBloc>(
              create: (BuildContext context) => ExpenseBloc())
        ],
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
