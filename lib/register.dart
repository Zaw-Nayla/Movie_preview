import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final _formKey = GlobalKey<FormState>();

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
                    margin: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Unlimited Movies, Shows and More',
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
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Ready to watch? Now Enter your email to create or access your account. ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )
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
                      controller: userregistController,
                      autovalidateMode: submitted
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      validator: RequiredValidator(errorText: 'Required'),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: ' Register Your Account',
                      ),
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
                      controller: passwordregistController,
                      obscureText: pass,
                      autovalidateMode: submitted
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      validator: passwordValidator,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: InputBorder.none,
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
                      controller: confirmpasswordregistController,
                      obscureText: confirmpass,
                      autovalidateMode: submitted
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      validator: (val) =>
                          MatchValidator(errorText: 'passwords do not match')
                              .validateMatch(val!, passwordregistController.text),
                      onChanged: (value) {},
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  confirmpass = !confirmpass;
                                });
                              },
                              icon: confirmpass
                                  ? const Icon(
                                      Icons.remove_red_eye,
                                      color: Color.fromARGB(163, 20, 20, 20),
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: Color.fromARGB(163, 19, 18, 18),
                                    )),
                          hintText: 'Comfirm Your Password'),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          submitted = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('userValue', userregistController.text);
                          prefs.setString(
                              'passValue', passwordregistController.text);
                          setState(() {
                            Navigator.pushNamed(context, '/login');
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: const EdgeInsets.only(left: 120, right: 120),
                        elevation: 15,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Sign Up',
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
                                color: Color.fromARGB(143, 255, 255, 255)),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.pushNamed(context, '/login');
                                });
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 148, 209, 240)),
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
