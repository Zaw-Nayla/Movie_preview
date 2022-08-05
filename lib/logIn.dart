import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final _formKey = GlobalKey<FormState>();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
  ]);

  bool eye = true;
  var dropdownValue = '2';

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
                              blurRadius: 5.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.5),
                      ])),
                  child: TextFormField(
                    controller: usernamecontroller,
                    autovalidateMode: submitted
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    validator: RequiredValidator(errorText: 'Required'),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Your Account',
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20),
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.5),
                      ])),
                  child: TextFormField(
                    controller: passwordcontroller,
                    obscureText: pass,
                    autovalidateMode: submitted
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    validator: passwordValidator,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.key_sharp,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              pass = !pass;
                            });
                          },
                          icon: pass
                              ? const Icon(
                                  Icons.remove_red_eye,
                                  color: Color.fromARGB(163, 20, 20, 20),
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Color.fromARGB(163, 19, 18, 18),
                                )),
                      hintText: 'Enter Password',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
            ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final String? username = prefs.getString('userValue');
                  final String? password = prefs.getString('passValue');
                  setState(() {
                    print(
                        '$username + $password');
                    if (usernamecontroller.text == username &&
                        passwordcontroller.text == password) {
                      Navigator.pushNamed(context, '/main');
                      usernamecontroller.clear();
                      passwordcontroller.clear();
                    }
                  });
                },style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: const EdgeInsets.only(left: 120, right: 120),
                  elevation: 15,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Log In',
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
                              color: Color.fromARGB(143, 255, 255, 255)),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pushNamed(context, '/register');
                              });
                            },
                            child: const Text('Sign UP',
                            style: TextStyle(
                              color: Color.fromARGB(255, 148, 209, 240)
                            ),))
                      ],
                    ))
          ]),
        ),
      ),
    ));
  }
}
