import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../components/choose_photo.dart';

class ChoosePhotoPage extends StatelessWidget {
  static const routeName = 'choosePhotoPage';
  @override
  Widget build(BuildContext context) {
    final LocationData locationData = ModalRoute.of(context).settings.arguments;
    print(locationData);
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
        centerTitle: true,
      ),
      body: ChoosePhoto(locationData: locationData)
    );
  }
}