import 'package:finance/blocs/ExpenseBloc/monitorBloc.dart';
import 'package:finance/blocs/RestApiBloc/authStates.dart';
import 'package:finance/pages/expensesWrapper.dart';
import 'package:finance/pages/login.dart';
import 'package:finance/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/RestApiBloc/NewAuthBloc.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WrapperState();
  }
}

class WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    MonitorBloc monitor = context.watch<MonitorBloc>();
    return BlocConsumer<NewAuthBloc, AuthStates>(
      listener: (context, state) {
        if (state is AuthenticationErrorState) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Authentication Error"),
                  content: Text("Something went wrong."),
                );
              });
        }
      },
      builder: (context, state) {
        if (state is RegisterState) {
          return Register();
        } else if (state is AuthSuccessState) {
          monitor.add(AskNewList());
          return ExpensesWrapper();
        } else {
          return Finance();
        }
      },
    );
  }
}
