import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FullScreenImage extends StatefulWidget {
  String image_url;
  String dogName;
  FullScreenImage({this.image_url, this.dogName});
  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
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
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: new Text(
          widget.dogName.toString()[0].toUpperCase() +
              widget.dogName.toString().substring(1),
          style: GoogleFonts.pacifico(fontSize: 28.0),
        ),
      ),
      body: Center(child: Image.network(widget.image_url)),
    );
  }
}
