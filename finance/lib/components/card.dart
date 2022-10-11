import 'dart:math';
import '../utils/httpHelper.dart' show ICard;

import 'package:flutter/material.dart';

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
    return SizedBox(
      height: 150,
      width: 150,
      child: Card(
        color: Colors.blue[300],
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Card(
              color: Colors.blue[200],
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    widget.card!.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))),
          Card(
              color: Colors.blue[200],
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('R\$ ' + widget.card!.cost))),
          Card(
              color: Colors.blue[200],
              child: Padding(
                  padding: EdgeInsets.all(5.0), child: Text(widget.card!.date)))
        ]),
      ),
    );
  }
}
