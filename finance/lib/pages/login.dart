
import 'package:finance/blocs/RestApiBloc/NewAuthBloc.dart';
import 'package:finance/blocs/RestApiBloc/authEvents.dart';
import 'package:finance/blocs/RestApiBloc/authStates.dart';
import 'package:finance/utils/httpHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './expenses.dart';
import './register.dart';

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
        body: Center(
      child: BlocBuilder<NewAuthBloc, AuthStates>(
        bloc: authBloc,
        builder: (context, state) =>Container(
          constraints: BoxConstraints(
              minHeight: 40, maxHeight: 350, maxWidth: 500, minWidth: 40),
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
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(height: 10),
              TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Digite o email',
                    labelText: 'Email *',
                  )),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  hintText: 'Digite a senha',
                  labelText: 'Password*',
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

                       try {
                         final response = await httpHelper.GetCreds(emailValue, passwordValue);
                          if (response.userId != "" && response.token != "") {
                          authBloc.add(AuthenticationEvent(token:response.token, userId: response.userId));
                          authBloc.add(await LoadExpenses());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Expenses()),
                          );
                        } else {
                          final snackBar = SnackBar(
                            content: const Text('Senha ou usuário incorretos!'),
                            action: SnackBarAction(
                              label: 'limpar',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                       } catch (e) {
                         final snackBar = SnackBar(
                            content: const Text('Senha ou usuário incorretos!'),
                            action: SnackBarAction(
                              label: 'limpar',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } 
                      },
                    )),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Registrar'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()),
                        );
                      },
                    ))
              ], mainAxisAlignment: MainAxisAlignment.center)
            ],
          )),) 
    )));
  }
}
