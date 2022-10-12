import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/httpHelper.dart' show HttpHelper;
import '../utils/httpHelper.dart' show ExpenseBody;
import '../blocs/authBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardForm extends StatefulWidget {
   String token;
   String userId;
   CardForm({super.key, this.token = '', this.userId = ''});

  @override
  CardFormState createState() {
    return CardFormState();
  }
}

class CardFormState extends State<CardForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController costController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = context.watch<AuthBloc>();
    return Form(
      key: _formKey,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  icon: Icon(Icons.text_fields), //icon of text field
                  labelText: 'Digite o título' //label text of field
                  ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite o título';
                }
                return null;
              },
            ),
            TextFormField(
              controller: costController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[. 0-9]"))
              ],
              decoration: InputDecoration(
                  icon: Icon(Icons.money_off_rounded), //icon of text field
                  labelText: 'Digite o custo' //label text of field
                  ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite o custo';
                }
                return null;
              },
            ),
            TextFormField(
              controller: dateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  icon: Icon(Icons.date_range), //icon of text field
                  labelText: 'Digite a data' //label text of field
                  ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Escolha a data';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                  child: ElevatedButton(
                onPressed: ()async  {
                  var http = HttpHelper();
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processando')),
                    );
                    ExpenseBody card = ExpenseBody(titleController.text, costController.text, dateController.text, authBloc.state.userId);
                    if(await http.CreateExpense(card, authBloc.state.token) ){
                      var result = await authBloc.GetExpenses();
                      var message = "algo deu errado";
                      if(result){
                          message = 'Despesa Criada com Sucesso!';
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text(message)),
                    );
                    }

                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Algo deu errado na criação da despesa!')),
                    );
                    }
                  }
                },
                child: const Text('Adicionar Despesa'),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
