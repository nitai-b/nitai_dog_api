import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nitai_dog_api/models/dog_api.dart';
import 'package:nitai_dog_api/view/details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dogAPI = DogAPI();

  Future getAllBreeds() async {
    var _allDogs = await dogAPI.getAllDogs();
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
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0))),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: new Text(
          'Dog Breeds',
          style: GoogleFonts.pacifico(fontSize: 28.0),
        ),
      ),
      body: Container(
        // child:
        child: FutureBuilder(
          future: getAllBreeds(),
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
                    // print(asyncSnapshot.data.keys.toList().toString());
                    if (asyncSnapshot.data.values.toList()[index].toString() ==
                        '[]') {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                      dogName: asyncSnapshot.data.keys
                                          .toList()[index])));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              // trailing: Icon(Icons.arrow_forward_ios),
                              title: Text(
                                asyncSnapshot.data.keys
                                        .toList()[index]
                                        .toString()[0]
                                        .toUpperCase() +
                                    asyncSnapshot.data.keys
                                        .toList()[index]
                                        .toString()
                                        .substring(1),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.indieFlower(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                      dogName: asyncSnapshot.data.keys
                                          .toList()[index])));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  // trailing: Icon(Icons.arrow_forward_ios),
                                  title: Text(
                                      asyncSnapshot.data.keys
                                              .toList()[index]
                                              .toString()[0]
                                              .toUpperCase() +
                                          asyncSnapshot.data.keys
                                              .toList()[index]
                                              .toString()
                                              .substring(1),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.indieFlower(
                                          fontSize: 20.0)),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: Text(
                                    'Sub-breeds:',
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  asyncSnapshot.data.values
                                      .toList()[index]
                                      .reduce((value, element) {
                                    return value + ", " + element;
                                  }),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
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
