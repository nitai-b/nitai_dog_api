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
}
