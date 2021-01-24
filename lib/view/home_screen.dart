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

  Future getAllBreeds() async {
    var _allDogs = await dogAPI.getAllDogs();
    // _allBreeds = _allDogs.keys.toList();
    return _allDogs;
  }

  @override
  void initState() {
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
              print('trying to refresh');
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
          future: getAllBreeds(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.none && asyncSnapshot.hasData == null) {
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
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {}));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(asyncSnapshot.data.keys.toList()[index].toString()[0].toUpperCase() +
                                asyncSnapshot.data.keys.toList()[index].toString().substring(1)),
                            subtitle: Text(asyncSnapshot.data.values.toList()[index].toString() == '[]'
                                ? 'no sub-breeds available'
                                : 'Sub-breed: ${asyncSnapshot.data.values.toList()[index].toString()}'),
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
