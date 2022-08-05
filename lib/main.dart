import 'package:moviedb/Object.dart';

import 'API.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

List<Movie>? playingMovies;
List<Movie>? upComingMovies;
int ind = 0;

class _HomePageState extends State<HomePage> {
  myPlaying() {
    API().nowPlaying().then((value) {
      setState(() {
        playingMovies = value;
      });
    });

    API().upComing().then((value) {
      setState(() {
        upComingMovies = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    myPlaying();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Movie DataBase'),
        backgroundColor: const Color.fromARGB(80, 158, 158, 158),
      ),
      body: Column(children: [
        // const SizedBox(
        //   height: 10,
        // ),
        Container(
          // color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          height: 50,
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Now Playing',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
        playingMovies == null
            ? const Center(
                child: SpinKitCubeGrid(
                  color: Colors.grey,
                  size: 40.0,
                ),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 160,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: playingMovies!.length,
                    itemBuilder: (context, index) {
                      return Design(
                        imageint: index,
                        Movietype: playingMovies,
                        second: true,
                      );
                    }),
              ),
        Container(
          // color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          height: 50,
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                ' Up Coming',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
        upComingMovies == null
            ? const Center(
                child: SpinKitCubeGrid(
                  color: Colors.grey,
                  size: 40.0,
                ),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 160,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: upComingMovies!.length,
                    itemBuilder: (context, index) {
                      return Design(
                        imageint: index,
                        Movietype: upComingMovies,
                        second: false,
                      );
                    }),
              ),
      ]),
    );
  }
}

class Design extends StatelessWidget {
  int imageint;
  List<Movie>? Movietype;
  bool second;
  Design(
      {Key? key,
      required this.imageint,
      required this.Movietype,
      required this.second})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(imageint);
        showDialog(
            context: context,
            builder: (context) {
              return PopupDialog(
                movienum: imageint,
                Movietype: second ? playingMovies : upComingMovies,
              );
            });
      },
      child: Movietype == null
          ? const Center(
              child: SpinKitCubeGrid(
                color: Colors.grey,
                size: 40.0,
              ),
            )
          : Container(
              width: 250,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/original${Movietype![imageint].backdropPath}'))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(142, 0, 0, 0),
                    radius: 12,
                    child: Text(
                      '${Movietype![imageint].voteAverage}',
                      style: const TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      Movietype![imageint].originalTitle,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class PopupDialog extends StatelessWidget {
  int movienum;
  List<Movie>? Movietype;
  PopupDialog({Key? key, required this.movienum, required this.Movietype})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: const Color.fromARGB(173, 255, 255, 255),
        padding: const EdgeInsets.all(5),
        height: 250,
        width: 350,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Movietype == null
                ? const Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: SpinKitCubeGrid(
                        color: Colors.grey,
                        size: 40.0,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w200${Movietype![movienum].posterPath}'),
                        )),
                  ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: 150,
                    child: Text(
                      Movietype![movienum].originalTitle,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8),
                  child: SizedBox(
                    width: 150,
                    child: Text(
                      'Release Date : ${Movietype![movienum].releaseDate}',
                      style: const TextStyle(
                          fontSize: 12, color: Color.fromARGB(178, 0, 0, 0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: 150,
                    child: Row(
                      children: [
                        const Text(
                          'IMDB Rating : ',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          '${Movietype![movienum].voteAverage}',
                          style: TextStyle(
                              fontSize: 15,
                              color: Movietype![movienum].voteAverage > 7
                                  ? const Color.fromARGB(255, 26, 88, 29)
                                  : const Color.fromARGB(255, 123, 123, 0),
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    width: 150,
                    child: Text(
                      'Casts : ',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 15,
                          child: Icon(Icons.play_arrow),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(90, 255, 255, 255),
                          radius: 15,
                          child: Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(90, 255, 255, 255),
                          radius: 15,
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
