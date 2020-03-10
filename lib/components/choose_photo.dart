import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as Path;
import 'package:location/location.dart';
import '../screens/list_page.dart';

class ChoosePhoto extends StatefulWidget {
  ChoosePhoto({Key key, this.locationData}) : super(key: key);
  LocationData locationData;
  @override
  _ChoosePhotoState createState() => _ChoosePhotoState();
}

class _ChoosePhotoState extends State<ChoosePhoto> {
  File image;
  final formKey = GlobalKey<FormState>();

  String numItems;
  String url; 

  void getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    String timestmp = DateTime.now().millisecondsSinceEpoch.toString();  
    StorageReference storageReference =
    FirebaseStorage.instance.ref().child(Path.basename(image.path) + timestmp) ?? null;
    if (storageReference != null) {
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      url = await storageReference.getDownloadURL();
    }
    setState(() {});
  }

  @override

  Widget build(BuildContext context) {
    bool entry = true; 
    if (image == null) {
      return Center(
        child: RaisedButton(
          child: Text('Select Photo'),
          onPressed: () {
            getImage();
          },
        ));
    } 
    else {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child:ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(image),
            SizedBox(height: 40),
            Text('Number of items:', textAlign: TextAlign.center,),
            Container(
              margin: EdgeInsets.fromLTRB(100, 0, 100, 0),
              child: TextFormField(
                // decoration: InputDecoration(labelText: 'Number of items'),
                keyboardType: TextInputType.number,
                autofocus: true,
                textAlign: TextAlign.center,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                decoration: InputDecoration(border: OutlineInputBorder(), filled: true, fillColor: Colors.grey[300],
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10)),
                onSaved: (value) {
                  numItems = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a value';
                  } else {
                    return null;
                  }
                },
              )
            ),
            SizedBox(height: 100),
            Container(
              alignment: Alignment.bottomCenter,
              child:Semantics(
                label: 'Upload button for uploading food waste picture',
                child:RaisedButton(
                child: Text('UPLOAD'),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    Firestore.instance.collection('wasteagrams').add({
                      'date': DateTime.now(),
                      'waste_count': numItems,
                      'image_url': url,
                      'long': widget.locationData.longitude,
                      'lat': widget.locationData.latitude
                    });
                    Navigator.of(context).pushNamed(ListPage.routeName);
                }
                },
              )
              )
            )
          ],
        ))
      );
    }
  }
}