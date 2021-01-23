import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nitai_dog_api/models/dog_api.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dogAPI = DogAPI();
  List<String> _allBreeds;

  Future getAllMainBreeds() async {
    var _allDogs = await dogAPI.getAllDogs();
    _allBreeds = _allDogs.keys.toList();
    return _allBreeds;
  }

  Future getAllSubBreeds() async {
    return 'this is a sub breed';
  }

  @override
  void initState() {
    // getAllMainBreeds();
    // getAllSubBreeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // dogList.getBreeds();
            },
          )
        ],
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: new Text(
          'Dog Breeds',
          style: GoogleFonts.pacifico(),
        ),
      ),
      body: Container(
        // child:
        child: FutureBuilder(
          future: getAllMainBreeds(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.none && asyncSnapshot.hasData == null) {
              return Center(child: Text('Oops... No Internet'));
            }
            if (asyncSnapshot.hasError) {
              return Center(child: Text('Oops... an error occured'));
            }
            if (asyncSnapshot.hasData) {

              print
              return ListView.builder(
                  itemCount: asyncSnapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {}));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(asyncSnapshot.data[index].toString()[0].toUpperCase() +
                                asyncSnapshot.data[index].toString().substring(1)),
                            subtitle: Text('Breed Description'),
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
