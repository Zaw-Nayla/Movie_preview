import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userregistController = TextEditingController();
  TextEditingController passwordregistController = TextEditingController();
  TextEditingController confirmpasswordregistController =
      TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/netflix.jpg'),
            fit: BoxFit.fill,
          )),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      'Unlimited Movies,Shows and More',
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
                            blurRadius: 5.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 80,
                    width: 300,
                    child: TextFormField(
                      controller: userregistController,
                      autovalidateMode: submitted
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      validator: emialValidator,
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(157, 0, 0, 0)),
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
                          hintText: 'Enter Your Email ',
                          hintStyle: const TextStyle(color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: 300,
                    child: TextFormField(
                      controller: passwordregistController,
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
                                width: 1, color: Color.fromARGB(157, 0, 0, 0)),
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
                          filled: true,
                          fillColor: const Color.fromARGB(178, 255, 255, 255),
                          hintText: 'Enter Password',
                          hintStyle: const TextStyle(color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: 300,
                    child: TextFormField(
                      controller: confirmpasswordregistController,
                      obscureText: confirmpass,
                      autovalidateMode: submitted
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      validator: (val) => MatchValidator(
                              errorText: 'passwords do not match')
                          .validateMatch(val!, passwordregistController.text),
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(157, 0, 0, 0)),
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
                          // filled: true,
                          // fillColor: const Color.fromARGB(178, 255, 255, 255),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  confirmpass = !confirmpass;
                                });
                              },
                              splashRadius: 2,
                              icon: confirmpass
                                  ? const Icon(
                                      Icons.remove_red_eye,
                                      color: Color.fromARGB(254, 20, 20, 20),
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: Color.fromARGB(254, 19, 18, 18),
                                    )),
                          filled: true,
                          fillColor: const Color.fromARGB(178, 255, 255, 255),
                          hintText: 'Comfirm Your Password',
                          hintStyle: const TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isloading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            submitted = true;
                          });
                          try {
                            final auth = FirebaseAuth.instance;

                            final newUser =
                                await auth.createUserWithEmailAndPassword(
                                    email: userregistController.text,
                                    password: passwordregistController.text);
                            print(newUser.user!.uid);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            prefs.setString('UserID', newUser.user!.uid);
                            setState(() {
                              isloading = false;
                              Navigator.pushNamed(context, '/login');
                              userregistController.clear();
                              passwordregistController.clear();
                            });
                          } catch (e) {
                            setState(() {
                              isloading = false;
                            });
                            print('Error >>>>>>>> $e');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: const EdgeInsets.only(left: 110, right: 110),
                        elevation: 15,
                      ),
                      child: (isloading)
                          ? const SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ))
                          : const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'SignUp',
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
                            'Already have an account?',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.pushNamed(context, '/login');
                                });
                              },
                              child: const Text(
                                'SignIn',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 148, 240, 234)),
                              ))
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
