// ignore: file_names
import 'package:http/http.dart' as http;
import 'package:moviedb/creditsmodel.dart';
import 'package:moviedb/model.dart';

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

  Future<List<Movie>> popular() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=050c28541f900007285c3020069bfd62&language=en-US&page=1');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      var movieresult = OverallResp.fromRawJson(resp.body);
      return movieresult.results;
    } else {
      throw Exception('Unable to Assest API');
      // print(resp.statusCode);
    }
  }
}

class CreditsAPI {
  Future<List<Cast>> credits(int id) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=050c28541f900007285c3020069bfd62&language=en-US');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      var casts = Credits.fromRawJson(resp.body);
      return casts.cast;
    } else {
      print(resp.statusCode);
      throw Exception('Unable to Assest API');
    }
  }
}
