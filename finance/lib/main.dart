import 'package:finance/blocs/RestApiBloc/NewAuthBloc.dart';
import 'package:finance/blocs/RestApiBloc/authEvents.dart';
import 'package:finance/blocs/ExpenseBloc/expenseBloc.dart';
import 'package:finance/pages/wrapper.dart';
import 'package:flutter/material.dart';
import './pages/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'blocs/ExpenseBloc/monitorBloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
              create: (BuildContext context) => ExpenseBloc()),
          BlocProvider<MonitorBloc>(
              create: (BuildContext context) => MonitorBloc()),
        ],
        child: MaterialApp(
          title: 'Finance App',
          home: Scaffold(
            body: const Center(
              child: Wrapper(),
            ),
          ),
        ));
  }
}
