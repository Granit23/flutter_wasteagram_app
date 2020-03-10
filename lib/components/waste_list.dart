import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../screens/waste_detail_page.dart';


class WasteList extends StatefulWidget {
  // WasteList({Key key, this.entry}): super(key: key);

  @override
  _WasteListState createState() => _WasteListState();
}

class _WasteListState extends State<WasteList> {
  Stream wasteagrams = Firestore.instance.collection('wasteagrams').orderBy('date', descending: true).snapshots();
  @override
  Widget build(BuildContext context) {
      return StreamBuilder(
        stream: wasteagrams,
        builder: (content, snapshot) {
          if (snapshot.hasData && snapshot.data.documents.length != 0) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                // List postList = snapshot.data.orderBy;

                var post = snapshot.data.documents[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(WasteDetailPage.routeName, arguments: post);
                  },
                  child:Semantics(
                    label: 'Date: ${DateFormat('EEEE, MMM d').format(post['date'].toDate()).toString()}, Food Waste: ${post['waste_count'].toString()}',
                    child:ListTile(
                  title: Text(DateFormat('EEEE, MMM d').format(post['date'].toDate()).toString()),
                  trailing: Text(post['waste_count'].toString())
                )));
              }
            );
          } else {
            return Center(child:CircularProgressIndicator());
          }
        }
      );
    }
}