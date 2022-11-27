import 'package:finance/blocs/RestApiBloc/NewAuthBloc.dart';
import 'package:finance/blocs/ExpenseBloc/expenseBloc.dart';
import 'package:finance/blocs/ExpenseBloc/expenseEvent.dart';
import 'package:finance/blocs/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardForm extends StatefulWidget {
   String userId;
   CardForm({super.key, this.userId = ''});

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
    NewAuthBloc authBloc = context.watch<NewAuthBloc>();
    ExpenseBloc expenseBloc = context.watch<ExpenseBloc>();
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
            SizedBox(height: 10),
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
            SizedBox(height: 10),
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
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processando')),
                    );
                    Expense card = Expense(titleController.text, costController.text, dateController.text);
                    expenseBloc.add(AddExpenseEvent(expense: card));

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
