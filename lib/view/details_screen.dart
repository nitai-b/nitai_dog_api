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

  Future getImages(dogName) async {
    var _allDogs = await dogAPI.getImages(dogName);
    return _allDogs;
  }

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
          widget.dogName.toString()[0].toUpperCase() + widget.dogName.toString().substring(1),
          style: GoogleFonts.pacifico(),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: getImages(widget.dogName),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.none && asyncSnapshot.hasData == null) {
              return Center(child: Text('Oops... No Internet'));
            }
            if (asyncSnapshot.hasError) {
              return Center(child: Text('Oops... an error occured'));
            }
            if (asyncSnapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(3.0),
                itemCount: asyncSnapshot.data.length,
                itemBuilder: (context, i) => ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: GridTile(
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id);
                      },
                      child: Image.network(
                        asyncSnapshot.data[i],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
              );
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
