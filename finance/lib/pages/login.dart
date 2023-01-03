import 'package:finance/blocs/RestApiBloc/NewAuthBloc.dart';
import 'package:finance/blocs/RestApiBloc/authEvents.dart';
import 'package:finance/blocs/RestApiBloc/authStates.dart';
import 'package:finance/utils/httpHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Finance extends StatefulWidget {
  const Finance({super.key});
  @override
  State<Finance> createState() => _Finance();
}

class _Finance extends State<Finance> {
  @override
  Widget build(BuildContext context) => Scaffold(body: FinanceForm());
}

class FinanceForm extends StatefulWidget {
  const FinanceForm({super.key});
  @override
  State<FinanceForm> createState() => _FinanceForm();
}

class _FinanceForm extends State<FinanceForm> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String passwordValue = 'no password';
  String emailValue = 'no email';
  HttpHelper httpHelper = HttpHelper();

  Widget build(BuildContext context) {
    NewAuthBloc authBloc = context.watch<NewAuthBloc>();
    return (Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
        ),
        body: Center(
            child: BlocBuilder<NewAuthBloc, AuthStates>(
          bloc: authBloc,
          builder: (context, state) => Container(
              constraints: BoxConstraints(
                  minHeight: 40, maxHeight: 300, maxWidth: 450, minWidth: 40),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 222, 222, 222),
                  borderRadius: BorderRadius.circular(40)),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.calculate_sharp, size: 50),
                      Text(
                        'Finance App',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Type your email',
                        labelText: 'Email *',
                      )),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.password),
                      hintText: 'Type your password',
                      labelText: 'Password *',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(children: [
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Login'),
                          onPressed: () async {
                            setState(() {
                              passwordValue = passwordController.text;
                              emailValue = emailController.text;
                            });
                            authBloc.add(AuthenticationEvent(
                                email: emailValue, password: passwordValue));
                          },
                        )),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Register'),
                          onPressed: () {
                            authBloc.add(RegisterEvent());
                          },
                        ))
                  ], mainAxisAlignment: MainAxisAlignment.center)
                ],
              )),
        ))));
  }
}
