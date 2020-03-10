import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';



class WasteDetail extends StatelessWidget {
  @override
  DocumentSnapshot entries;
  WasteDetail(this.entries);
   
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(DateFormat('EEEE, MMM d').format(entries['date'].toDate()).toString(), style: TextStyle(
            fontSize: 35
          )),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 250,
            width: 300,
            child:Image(image: NetworkImage(entries['image_url'])) ?? Text('Picture Missing')
          ),
          Text('Items: ${entries['waste_count'].toString()}', style: TextStyle(fontSize: 23)),
          SizedBox(height: 20,),
          Text('(${entries['lat'].toString()},    ${entries['long'].toString()})')
        ]
      )
    );
  }
}