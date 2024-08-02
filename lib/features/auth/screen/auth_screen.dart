import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String routeName = '/auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  final AuthService authservice = AuthService();
  final TextEditingController _nameControllor = TextEditingController();
  final TextEditingController _emailControllor = TextEditingController();
  final TextEditingController _passwordControllor = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameControllor.dispose();
    _emailControllor.dispose();
    _passwordControllor.dispose();
  }

  void signUpUser() {
    authservice.signUpUser(
        context: context,
        email: _emailControllor.text,
        password: _passwordControllor.text,
        name: _nameControllor.text);
  }

  void singInUser() {
    authservice.signInUser(
      context: context,
      email: _emailControllor.text,
      password: _passwordControllor.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color.fromARGB(255, 220, 218, 218),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      tileColor: _auth == Auth.signup
                          ? Colors.white
                          : Color.fromARGB(255, 220, 218, 218),
                      title: Text(
                        "Create Account",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Radio(
                        activeColor: Colors.orange,
                        value: Auth.signup,
                        groupValue: _auth,
                        onChanged: (Auth? val) {
                          setState(() {
                            _auth = val!;
                          });
                        },
                      ),
                    ),
                    if (_auth == Auth.signup)
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Form(
                          key: _signupFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                  controller: _nameControllor,
                                  hintText: "Name"),
                              const SizedBox(height: 10),
                              CustomTextField(
                                  controller: _emailControllor,
                                  hintText: "Email"),
                              const SizedBox(height: 10),
                              CustomTextField(
                                  controller: _passwordControllor,
                                  hintText: "Password"),
                              const SizedBox(height: 10),
                              CustomButton(
                                  text: 'Sign Up',
                                  onTap: () {
                                    if (_signupFormKey.currentState!
                                        .validate()) {
                                      signUpUser();
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ListTile(
                      tileColor: _auth == Auth.signin
                          ? Colors.white
                          : Color.fromARGB(255, 220, 218, 218),
                      title: Text(
                        "Sign-In.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Radio(
                        activeColor: Colors.orange,
                        value: Auth.signin,
                        groupValue: _auth,
                        onChanged: (Auth? val) {
                          setState(() {
                            _auth = val!;
                          });
                        },
                      ),
                    ),
                    if (_auth == Auth.signin)
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white),
                        child: Form(
                          key: _signinFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                  controller: _emailControllor,
                                  hintText: "Email"),
                              const SizedBox(height: 10),
                              CustomTextField(
                                  controller: _passwordControllor,
                                  hintText: "Password"),
                              const SizedBox(height: 10),
                              CustomButton(
                                  text: 'Sign In',
                                  onTap: () {
                                    if (_signinFormKey.currentState!
                                        .validate()) {
                                      singInUser();
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
