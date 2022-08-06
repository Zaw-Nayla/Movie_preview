// ignore: file_names

import 'package:flutter/material.dart';

class FrontScreen extends StatefulWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/netflix.jpg'),
            fit: BoxFit.fill,
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(20),
                    height: 60,
                    width: 360,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.5),
                        ])),
                    child: const Text(
                      ' H U B F L I X',
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Libre',
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 60,
                ),
                IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pushNamed(context, '/login');
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(203, 234, 16, 16),
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          elevation: 15,
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Log IN',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Edu',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ))),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          elevation: 15,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Sign UP',
                            style: TextStyle(
                              color: Color.fromARGB(155, 234, 16, 16),
                              fontFamily: 'Edu',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
