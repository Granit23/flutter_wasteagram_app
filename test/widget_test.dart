import 'dart:math';

import 'package:test/test.dart';
import 'package:wasteagram/models/wasteagram_data.dart';

void main() {
  test('Test the wasteagram data object', () {
    var date = DateTime.parse('2020-01-01');
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    var entries = {
      'date': date,
      'image_url': url,
      'waste_count': quantity,
      'lat': latitude,
      'long': longitude
    };

    final entry = Wasteagram.fromMap(date, quantity, longitude, latitude, url);
    
    expect(entry.date, date);
    expect(entry.url, url);
    expect(entry.waste_count, quantity);
  

  }); 
}
