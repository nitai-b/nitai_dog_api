import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nitai_dog_api/models/dog_api.dart';

class DetailsScreen extends StatefulWidget {
  String dogName;

  DetailsScreen({this.dogName});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  var dogAPI = DogAPI();

  // Future getAllBreeds() async {
  //   var _allDogs = await dogAPI.getAllDogs();
  //   return _allDogs;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              print('trying to refresh');
            },
          )
        ],
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: new Text(
          widget.dogName.toString()[0].toUpperCase() +
              widget.dogName.toString().substring(1),
          style: GoogleFonts.pacifico(),
        ),
      ),
      body: Container(
        // child:
        child: FutureBuilder(
          future: null,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.none &&
                asyncSnapshot.hasData == null) {
              return Center(child: Text('Oops... No Internet'));
            }
            if (asyncSnapshot.hasError) {
              return Center(child: Text('Oops... an error occured'));
            }
            if (asyncSnapshot.hasData) {
              return ListView.builder(
                  itemCount: asyncSnapshot.data.keys.toList().length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(''),
                            subtitle: Text(''),
                          ),
                        ),
                      ),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
