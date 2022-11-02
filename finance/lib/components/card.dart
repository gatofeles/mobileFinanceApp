import 'dart:math';
import '../utils/httpHelper.dart' show ICard;
import 'package:flutter/material.dart';
import '../utils/httpHelper.dart' show HttpHelper;
import '../blocs/authBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ECard extends StatefulWidget {
  const ECard({
    super.key,
    this.card,
    this.color = const Color(0xFF006064),
  });

  final ICard? card;
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
    AuthBloc authBloc = context.watch<AuthBloc>();
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Excluindo Despesa...')),
              );
              var httpHelper = HttpHelper();
              var result = await httpHelper.DeleteExpense(
                  widget.card!, authBloc.state.token);
              if (result) {
                var result2 = await authBloc.GetExpenses();
                if (result2) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Despesa Excluída com sucesso.')),
                  );
                }
              }
            },
          )
        ]),
      ),
    );
  }
}
