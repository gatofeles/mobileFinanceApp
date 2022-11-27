import 'package:finance/blocs/ExpenseBloc/expenseBloc.dart';
import 'package:finance/blocs/ExpenseBloc/expenseEvent.dart';
import '../blocs/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ECard extends StatefulWidget {
  const ECard({
    super.key,
    this.card,
    this.color = const Color(0xFF006064),
    this.id
  });
  final String? id;
  final Expense? card;
  final Color color;

  @override
  State<ECard> createState() => _ECardState();
}

class _ECardState extends State<ECard> {
  double _size = 1.0;

  void grow() {
    setState(() {
      _size += 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    ExpenseBloc expenseBloc = context.watch<ExpenseBloc>();
    return SizedBox(
      height: 100,
      child: Card(
        color: Color(0xff3a3a3a),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Card(
              color: Color(0xff708995),
              child: Column(
                children: [
                  Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Título",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      color: Color.fromARGB(255, 194, 194, 194)),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        widget.card!.title,
                      ))
                ],
              )),
          Card(
              color: Color(0xff708995),
              child: Column(
                children: [
                  Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Custo",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      color: Color.fromARGB(255, 194, 194, 194)),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "R\$ " + widget.card!.cost,
                      ))
                ],
              )),
          Card(
              color: Color(0xff708995),
              child:Column(children: [Card(child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Data", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              color: Color.fromARGB(255, 194, 194, 194)), Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    widget.card!.date,
                  ))],) ),
          InkWell(
            child: Card(
                color: Color.fromARGB(255, 215, 71, 19),
                child: Padding(
                    padding: EdgeInsets.all(10.0), child: Text('Excluir'))),
            onTap: () async {            
              expenseBloc.add(DeleteExpenseEvent(expenseId: widget.id!));     
            },
          )
        ]),
      ),
    );
  }
}
