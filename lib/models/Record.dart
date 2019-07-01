class Record {
  String name;
  String address;
  String contact;
  String photo;
  String url;

  Record({this.name, this.address, this.contact, this.photo, this.url});

  //the factory constructor returns objects (values)
  //it parses the given JSON string and returns a Record instance
  factory Record.fromJson(Map<String, dynamic> json) {
    return new Record(
        name: json['name'],
        address: json['address'],
        contact: json['contact'],
        photo: json['photo'],
        url: json['url']);
  }
}
