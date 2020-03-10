import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'choose_photo_page.dart';
import '../components/waste_list.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/';
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Stream wasteagrams = Firestore.instance.collection('wasteagrams').snapshots();
  

  @override

  LocationData locationData;
  int total_waste;
  
  @override

  void initState() {
    super.initState();    
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState( () {} );
  }

  Widget build(BuildContext context) {
    return calcWaste(wasteagrams);
  }

  Widget calcWaste(Stream wasteagrams) {
    int sum = 0;
    return StreamBuilder(
      stream: wasteagrams,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data.documents.length; i++) {
            sum += int.parse(snapshot.data.documents[i]['waste_count']);
          }
        }
        return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Wasteagram - ${sum}'),
        centerTitle: true,
      ),
      body: WasteList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(ChoosePhotoPage.routeName, arguments: locationData);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
      }
    );
  }
}