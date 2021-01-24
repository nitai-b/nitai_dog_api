import 'dart:convert';

import 'package:http/http.dart' as http;

const String allBreedsString = 'https://dog.ceo/api/breeds/list/all';

class DogAPI {
  Future<Map> getAllDogs() async {
    var response = await http.get(allBreedsString);

    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      assert(map['status'] == 'success');
      return map['message'];
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<List<String>> getImages(breed) async {
    var json;
    // json = await http.get('https://dog.ceo/api/breed/$breed/images/random/$number');
    // json = await http.get('https://dog.ceo/api/breed/$breed/$subBreed/images/random/$number');
    json = await http.get('https://dog.ceo/api/breed/$breed/images');
    // json = await http.get('https://dog.ceo/api/breed/$breed/$subBreed/images');
    var map = jsonDecode(json.body);
    if (map['status'] == 'success') {
      return map['message'].cast<String>();
    } else {
      throw "Can't load image";
    }
  }
}
