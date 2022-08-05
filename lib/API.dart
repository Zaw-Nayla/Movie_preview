// import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:moviedb/Object.dart';

class API {
  Future<List<Movie>> nowPlaying() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=050c28541f900007285c3020069bfd62&language=en-US&page=1');
    final resp = await http.get(url);

    // print('Response body: ${resp.body}');
    if (resp.statusCode == 200) {
      var movieresult = OverallResp.fromRawJson(resp.body);
      // print(movieresult);
      return movieresult.results;
    } else {
      throw Exception('Unable to Assest API');
      // print(resp.statusCode);
    }
  }

  Future<List<Movie>> upComing() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=050c28541f900007285c3020069bfd62&language=en-US&page=1');
    final resp = await http.get(url);

    // print('Response body: ${resp.body}');
    if (resp.statusCode == 200) {
      var movieresult = OverallResp.fromRawJson(resp.body);
      // print(movieresult);
      return movieresult.results;
    } else {
      throw Exception('Unable to Assest API');
      // print(resp.statusCode);
    }
  }
}
