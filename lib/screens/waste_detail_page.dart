import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/waste_detail.dart';

class WasteDetailPage extends StatefulWidget {
  static const routeName = 'WasteDetailPagePage';
  @override
  _WasteDetailPageState createState() => _WasteDetailPageState();
}

class _WasteDetailPageState extends State<WasteDetailPage> {
  
  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot entries = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
        centerTitle: true,
      ),
      body: WasteDetail(entries)
    );
  }
}