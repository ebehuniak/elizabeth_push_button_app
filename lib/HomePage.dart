import 'package:flutter/material.dart';
import 'helpers/Constants.dart';
import 'models/Record.dart';
import 'models/RecordList.dart';
import 'models/RecordService.dart';

//maintains state of contact data
//HomePage will be called and used when navigating/presenting the page
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

//the private class _HomePageState will be called every
// time HomePage is called
class _HomePageState extends State<HomePage> {
  //this implements a listener for our searches
  final TextEditingController _filter = new TextEditingController();

  //keeps the state of our raw data
  RecordList _records = new RecordList();

  //keeps the state of our searched data
  RecordList _filteredRecords = new RecordList();

  //validates our searches
  String _searchText = "";

  //an Icon representation
  Icon _searchIcon = new Icon(Icons.search);

  //a text widget which we will use widely
  Widget _appBarTitle = new Text(appTitle);

  //settings for when the state is initialized
  //we empty our records data and get fresh data from the JSON file
  @override
  void initState() {
    super.initState();

    _records.records = new List();
    _filteredRecords.records = new List();

    _getRecords();
  }

  //an Async Call to introduce concepts and how to
  // call it if you were to perform a data fetch from a server
  void _getRecords() async {
    RecordList records = await RecordService().loadRecords();
    setState(() {
      for (Record record in records.records) {
        this._records.records.add(record);
        this._filteredRecords.records.add(record);
      }
    });
  }

  //create a UI structure
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //generates navigation bar
      appBar: _buildBar(context),
      backgroundColor: mainAppColor,
      body: _buildList(context),
      resizeToAvoidBottomPadding: false,
    );
  }

  //implements the _buildBar function
  Widget _buildBar(BuildContext context) {
    return new AppBar(
        elevation: 0.1,
        backgroundColor: mainAppColor,
        centerTitle: true,
        title: _appBarTitle,
        leading: new IconButton(icon: _searchIcon));
  }

  //implements the _buildList function
  //Here, we handle the mapping of our RecordList data into our
  // ListVew, and also handle any searches performed
  Widget _buildList(BuildContext context) {
    if (!(_searchText.isEmpty)) {
      _filteredRecords.records = new List();
      for (int i = 0; i < _records.records.length; i++) {
        if (_records.records[i].name
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
            _records.records[i].address
                .toLowerCase()
                .contains(_searchText.toLowerCase())) {
          _filteredRecords.records.add(_records.records[i]);
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: this
          ._filteredRecords
          .records
          .map((data) => _buildListItem(context, data))
          .toList(),
    );
  }

  //creates the _buildListItem function
  //the UI for each ListViewItem
  Widget _buildListItem(BuildContext context, Record record) {
    // Card class creates our Card-Like UI
    return Card(
      key: ValueKey(record.name),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        //In each Card, we have a ListTile
        // in each ListTile we have: leading, title, subtitle, trailing
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right:
                          new BorderSide(width: 1.0, color: Colors.white24))),
              child: Hero(
                  tag: "avatar_" + record.name,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(record.photo),
                  ))),
          title: Text(
            record.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              new Flexible(
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: record.address,
                        style: TextStyle(color: Colors.white),
                      ),
                      maxLines: 3,
                      softWrap: true,
                    )
                  ]))
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {},
        ),
      ),
    );
  }
}
