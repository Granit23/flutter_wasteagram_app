class Wasteagram {
  DateTime date;
  int waste_count;
  double long;
  double lat;
  String url;
  Map entry; 

  Wasteagram.fromMap(this.date, this.waste_count, this.long, this.lat, this.url) {
    entry = {
      'date': this.date,
      'image_url': this.url,
      'lat': this.lat,
      'long': this.long
    };
  }
}