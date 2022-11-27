import 'package:finance/blocs/RestApiBloc/NewAuthBloc.dart';
import 'package:finance/blocs/RestApiBloc/authEvents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/radio.dart' show RadioGender;

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  @override
  Widget build(BuildContext context) => Scaffold(body: RegisterForm());
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});
  @override
  State<RegisterForm> createState() => _RegisterForm();
}

class _RegisterForm extends State<RegisterForm> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController(); 

  Widget build(BuildContext context) {
     NewAuthBloc authBloc = context.watch<NewAuthBloc>();
    return (Scaffold(
        appBar: AppBar(
          title: const Text('Registro de Usuário'),
        ),
        body: Center(
          child: Container(
              constraints: BoxConstraints(
                  minHeight: 40, maxHeight: 400, maxWidth: 500, minWidth: 40),
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
                        hintText: 'Digite o email',
                        labelText: 'Email*',
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
                          child: const Text('Criar Usuário'),
                          onPressed: () async {
                            authBloc.add(CreateUserEvent(email: emailController.text, password: passwordController.text));
                            }
                        )),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Voltar ao Login'),
                          onPressed: () {
                            authBloc.add(Refresh());
                          },
                        ))
                  ], mainAxisAlignment: MainAxisAlignment.center)
                ],
              )),
        )));
  }
}
