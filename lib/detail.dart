import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moviedb/api.dart';
import 'package:moviedb/detailmodel.dart';
import 'package:moviedb/model.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  int imgint;
  List<Movie>? movietype;
  int id;
  DetailPage(
      {Key? key,
      required this.movietype,
      required this.imgint,
      required this.id})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Detail? details;
  List<Genre> gener = [];
  String gener1 = '';
  String tagline = '';
  int runtime = 0;
  String releasedate = '';
  String returndate = '';
  getdetail() {
    API().getDetails(widget.id).then((value) {
      setState(() {
        details = value;
        gener = details!.genres;
        // gener1 = details!.genres[0].name;
        // gener2 = details!.genres[1].name;
        tagline = details!.tagline;
        runtime = details!.runtime;
        releasedate = release(details!.releaseDate.toString());
      });
    });
  }

  String minutesToTimeOfDay(int minutes) {
    Duration duration = Duration(minutes: minutes);
    List<String> parts = duration.toString().split(':');
    return '${parts[0].toString()}h ${parts[1].toString()}m';
  }

  String release(String date) {
    List<String> party = date.toString().split(' ');
    if (party.isNotEmpty) {
      List<String> parts = party[0].toString().split('-');
      if (parts.isNotEmpty) {
        returndate =
            '${parts[2].toString()}/${parts[1].toString()}/${parts[0].toString()}';
      }
    }
    return returndate;
  }

  @override
  void initState() {
    getdetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rating = widget.movietype![widget.imgint].voteAverage / 10.round();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          ' Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(132, 0, 0, 0),
      ),
      body: details == null && widget.movietype == null
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
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w200${widget.movietype![widget.imgint].backdropPath}',
                        ),
                        fit: BoxFit.cover)),
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            // color: Colors.amber,
                            width: 120,
                            height: 180,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w200${widget.movietype![widget.imgint].posterPath}',
                                  placeholder: (context, url) => const SizedBox(
                                    child: Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: SpinKitFadingCube(
                                        color: Colors.white,
                                        size: 40.0,
                                      ),
                                    )),
                                  ),
                                  errorWidget: (context, url, error) => Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SizedBox(
                                        width: 200,
                                        child: Icon(
                                          Icons.error,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'Unavaliable',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )),
                                )
                                // Image(
                                //   image: NetworkImage(
                                //       'https://image.tmdb.org/t/p/w200${widget.movietype![widget.imgint].posterPath}'),
                                // ),
                                ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  widget.movietype![widget.imgint]
                                          .originalTitle ??
                                      'unavaliable',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 133, 233, 20)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: SizedBox(
                                  width: 200,
                                  height: 20,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: gener.length,
                                      itemBuilder: (context, index) {
                                        gener1 = gener[index].name;
                                        return Text(
                                          "$gener1 . ",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        );
                                      }),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 5),
                                child: Container(
                                    height: 20,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.timelapse_outlined,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            minutesToTimeOfDay(runtime)
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: SizedBox(
                                  width: 200,
                                  child: Text(
                                    tagline,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Libre',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  child: Text(
                                    ' Released on $releasedate',
                                    // '${widget.movietype![widget.imgint].releaseDate}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 20,
                                        child: SizedBox(
                                            child: Stack(
                                          children: <Widget>[
                                            Center(
                                              child: CircularProgressIndicator(
                                                  value: rating,
                                                  strokeWidth: 2,
                                                  color: (rating < 0.5)
                                                      ? Colors.redAccent
                                                      : (rating < 0.7)
                                                          ? Colors.yellow
                                                          : Colors.greenAccent),
                                            ),
                                            Center(
                                                child: Text(
                                              '${widget.movietype![widget.imgint].voteAverage}',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                          ],
                                        ))),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: const CircleAvatar(
                                        radius: 15,
                                        child: Icon(Icons.play_arrow),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: const CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(90, 255, 255, 255),
                                        radius: 15,
                                        child: Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: const CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(90, 255, 255, 255),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: widget.movietype![widget.imgint].overview == null
                      ? const Text(
                          'Overview : Unaviable',
                          maxLines: 3,
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        )
                      : Text(
                          '${widget.movietype![widget.imgint].overview}',
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                ),
              ),
            ]),
    );
  }
}
