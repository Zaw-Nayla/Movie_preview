import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List res = [];
int ind = 0;

class _HomePageState extends State<HomePage> {
  void NowPlaying() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=050c28541f900007285c3020069bfd62&language=en-US&page=1');
    var response = await http.get(url);

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var movieResponse = jsonDecode(response.body);

      setState(() {
        res = movieResponse['results'];
      });
      // print(">>>>>>>>>${movieResponse['results'][ind]['original_title']}");
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    NowPlaying();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Movie DataBase'),
        backgroundColor: Color.fromARGB(80, 158, 158, 158),
      ),
      body: Column(children: [
        const SizedBox(
          height: 40,
        ),
        Container(
          // color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          height: 50,
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('Now Playing',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),)
            ],
          ),
        ),
        res == []
            ? const Text('Loading.....')
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 160,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: res.length,
                    itemBuilder: (context, index) {
                      return Design(imageint: index);
                      // Row(
                      //   children: [
                      //     Container(
                      //       width: 210,
                      //       height: 200,
                      //       decoration: BoxDecoration(
                      //           image: DecorationImage(
                      //               alignment: Alignment.centerLeft,
                      //               image: NetworkImage(
                      //                   'https://image.tmdb.org/t/p/w200${res[index]["poster_path"]}'))),
                      //     ),
                      //     Text('${res[index]['original_title']}')
                      //   ],
                      // );
                    }),
              )
      ]),
    );
  }
}

class Design extends StatelessWidget {
  int imageint;
  Design({Key? key, required this.imageint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      // height: 100,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/original${res[imageint]["backdrop_path"]}'))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromARGB(142, 0, 0, 0),
            radius: 12,
            child: Text(
              '${res[imageint]['vote_average']}',
              style: const TextStyle(
                color: Colors.lightGreen,
                fontSize: 10,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              '${res[imageint]['original_title']}',
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ],
      ),
    );
  }
}
