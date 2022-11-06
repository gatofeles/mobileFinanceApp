import 'package:finance/blocs/authEvents.dart';
import 'package:flutter/material.dart';
import './pages/login.dart';
import './blocs/authBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/NewAuthBloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewAuthBloc()..add(LoadExpenses()),
        child: MaterialApp(
          title: 'Finance App',
          home: Scaffold(
            body: const Center(
              child:
               Finance(),
            ),
          ),
        ));
  }
}
