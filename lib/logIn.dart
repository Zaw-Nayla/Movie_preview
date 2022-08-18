// ignore: file_names
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyLogInPage extends StatefulWidget {
  const MyLogInPage({Key? key}) : super(key: key);

  @override
  State<MyLogInPage> createState() => _MyLogInPageState();
}

class _MyLogInPageState extends State<MyLogInPage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool pass = true;
  bool confirmpass = true;
  bool submitted = false;
  bool isloading = false;

  final _formKey = GlobalKey<FormState>();

  final emialValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'enter a valid email address'),
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
  ]);

  bool eye = true;
  var errorMassage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/netflix.jpg'),
              fit: BoxFit.cover,
            )),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Unlimited Movies, Shows, and More',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(10.0, 10.0),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  Shadow(
                                    offset: Offset(5.0, 5.0),
                                    blurRadius: 9.0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80,
                        width: 300,
                        child: TextFormField(
                          controller: usernamecontroller,
                          autovalidateMode: submitted
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          validator: emialValidator,
                          decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.red),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(157, 0, 0, 0)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(157, 0, 0, 0)),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(178, 255, 255, 255),
                              hintText: 'Enter Your Email Account',
                              hintStyle: const TextStyle(color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 300,
                        child: TextFormField(
                          controller: passwordcontroller,
                          obscureText: pass,
                          autovalidateMode: submitted
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          validator: passwordValidator,
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(157, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(157, 0, 0, 0)),
                                borderRadius: BorderRadius.circular(10)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: const Color.fromARGB(178, 255, 255, 255),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    pass = !pass;
                                  });
                                },
                                splashRadius: 2,
                                icon: pass
                                    ? const Icon(
                                        Icons.remove_red_eye,
                                        color: Color.fromARGB(254, 20, 20, 20),
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: Color.fromARGB(254, 19, 18, 18),
                                      )),
                            hintText: 'Enter Password',
                            hintStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            final String? username = prefs.getString('UserID');
                            setState(() {
                              submitted = true;
                              print('$username');
                            });
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isloading = true;
                              });
                              try {
                                final auth = FirebaseAuth.instance;
                                UserCredential currentUser =
                                    await auth.signInWithEmailAndPassword(
                                        email: usernamecontroller.text,
                                        password: passwordcontroller.text);
                                print(currentUser.user!.uid);
                                if (currentUser.user!.uid != null) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('/'));
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacementNamed(
                                      context, '/main');
                                  setState(() {
                                    isloading = false;
                                  });
                                  usernamecontroller.clear();
                                  passwordcontroller.clear();
                                }
                              } on FirebaseException catch (e) {
                                if (e.code == 'user-not-found') {
                                  errorMassage =
                                      'No user found with this E-mail';
                                } else if (e.code == 'wrong-password') {
                                  errorMassage = ' Wrong password !';
                                } else {
                                  errorMassage = e.code;
                                }
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(errorMassage),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 1)));
                                setState(() {
                                  isloading = false;
                                });
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(e.toString()),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 1)));
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding:
                                const EdgeInsets.only(left: 110, right: 110),
                            elevation: 15,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: isloading ?  const SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ))
                                :
                            const Text(
                              'LogIn',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Libre',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          )),
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Need to Create One?',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pushNamed(context, '/register');
                                    });
                                  },
                                  child: const Text(
                                    'SignUp',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Color.fromARGB(255, 148, 240, 234)),
                                  )),
                              const SizedBox(
                                height: 100,
                              )
                            ],
                          ))
                    ]),
              ),
            ),
          ),
        ));
  }
}
