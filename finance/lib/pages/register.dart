import 'package:finance/pages/login.dart';
import 'package:flutter/material.dart';
import '../utils/httpHelper.dart' show HttpHelper;
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
  TextEditingController userController = TextEditingController();
  HttpHelper httpHelper = HttpHelper();

  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: const Text('Despesas'),
        ),
        body: Center(
          child: Container(
              constraints: BoxConstraints(
                  minHeight: 40, maxHeight: 500, maxWidth: 500, minWidth: 40),
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
                    controller: userController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.password),
                      hintText: 'Digite usuário',
                      labelText: 'Usuário*',
                    ),
                  ),
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
                    SizedBox(height:80, child: RadioGender()),
                  SizedBox(height: 10),
                  Row(children: [
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Registrar'),
                          onPressed: () async {
                             final snackBar = SnackBar(
                                content:
                                    const Text('Criando Usuário...'),
                                action: SnackBarAction(
                                  label: 'limpar',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                            var result = await httpHelper.CreateUser(
                                userController.text,
                                emailController.text,
                                passwordController.text);

                            if (result) {
                              final snackBar = SnackBar(
                                content:
                                    const Text('Usuário criado com sucesso'),
                                action: SnackBarAction(
                                  label: 'limpar',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Finance()),
                              );
                            } else {
                              final snackBar = SnackBar(
                                content:
                                    const Text('Algo deu errado no registro.'),
                                action: SnackBarAction(
                                  label: 'limpar',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                        )),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Voltar ao Login'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Finance()),
                            );
                          },
                        ))
                  ], mainAxisAlignment: MainAxisAlignment.center)
                ],
              )),
        )));
  }
}
