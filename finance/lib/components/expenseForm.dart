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
    var regExp = RegExp('[0-9]{2}/[0-9]{2}/[0-9]{4}');
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
                  labelText: 'Type the title' //label text of field
                  ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Type the title!';
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
                  labelText: 'Type the cost' //label text of field
                  ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Type the cost!';
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
                  labelText: 'Type the date' //label text of field
                  ),
              validator: (value) {
                if (!regExp.hasMatch(value.toString())) {
                  return 'Use  dd/mm/yyyy format';
                }
                var splitedDate = value!.split('/');
                if (int.parse(splitedDate[0]) > 31 ||
                    int.parse(splitedDate[1]) > 12 ||
                    int.parse(splitedDate[0]) <= 0 ||
                    int.parse(splitedDate[1]) <= 0) {
                  return 'Use  dd/mm/yyyy format';
                }

                if (value == null || value.isEmpty) {
                  return 'Type the date!';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                  child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Creating Expense')),
                    );
                    Expense card = Expense(titleController.text,
                        costController.text, dateController.text);
                    expenseBloc.add(AddExpenseEvent(expense: card));
                  }
                },
                child: const Text('Add Expense'),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
