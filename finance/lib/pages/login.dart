import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/authBloc.dart';
import './expenses.dart';

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

  Widget build(BuildContext context) {
    AuthBloc authBloc = context.watch<AuthBloc>();
    return (Scaffold(
        body: Center(
      child: Container(
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

                        var result = await authBloc.GetTokenId(
                            passwordValue, emailValue);

                        if (result) {
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
                      },
                    )),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Register'),
                      onPressed: () {
                        setState(() {
                          passwordValue = passwordController.text;
                          emailValue = emailController.text;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Expenses()),
                        );
                      },
                    ))
              ], mainAxisAlignment: MainAxisAlignment.center)
            ],
          )),
    )));
  }
}
