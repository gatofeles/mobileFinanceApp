import 'dart:math';

import 'package:flutter/material.dart';

class ECard extends StatefulWidget {
  const ECard({
    super.key,
    this.title = 'n',
    this.description = '',
    this.date ='',
    this.value = '',
    this.color = const Color(0xFF006064),
  });

  final Color color;
  final String value;
  final String title;
  final String description;
  final String date;

  @override
  State<ECard> createState() => _ECardState();
}

class _ECardState extends State<ECard> {
  double _size = 1.0;

  void grow() {
    setState(() { _size += 0.1; });
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      transform: Matrix4.diagonal3Values(_size, _size, 1.0),
      height: 80,
      width: 180,
      child:Center(child:Column(children: [
        Text('Título: '+ widget.title),
        Text('Descrição: '+ widget.description),
        Text('Valor: '+ widget.value),
        Text('Data: '+ widget.date),
      ])) ,

            
       decoration: BoxDecoration(  
           color: Colors.blueAccent,
           borderRadius: BorderRadius.circular(10.0),
           boxShadow: [
            BoxShadow(
              color: Colors.grey ,
              blurRadius: 2.0,
              offset: Offset(2.0,2.0)
            )
          ]),
        
    );
  }
}