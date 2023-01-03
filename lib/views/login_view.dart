import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:upsitizen/constants/routes.dart';
import 'package:upsitizen/firebase_options.dart';
import 'package:upsitizen/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isObscure = true;
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                    future: Firebase.initializeApp(
                      options: DefaultFirebaseOptions.currentPlatform,
                    ),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          return Column(
                            children: [
                              SizedBox(
                                height: 155.0,
                                child: Image.asset(
                                  "assets/images/logo.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 45.0),
                              TextField(
                                controller: _email,
                                enableSuggestions: false,
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              TextField(
                                controller: _password,
                                obscureText: _isObscure,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(_isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(
                                        () {
                                          _isObscure = !_isObscure;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(30.0),
                                color: const Color(0xff01A0C7),
                                child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  onPressed: () async {
                                    final email = _email.text;
                                    final password = _password.text;
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                        email: email,
                                        password: password,
                                      );
                                      final user =
                                          FirebaseAuth.instance.currentUser;
                                      if (user?.emailVerified ?? false) {
                                        //if users are verified
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          contentRoute,
                                          (route) => false,
                                        );
                                      } else {
                                        //user not verified yet
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          verifyEmailRoute,
                                          (route) => false,
                                        );
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
                                        await showErrorDialog(
                                          context,
                                          'User not found',
                                        );
                                      } else if (e.code == 'wrong-password') {
                                        await showErrorDialog(
                                          context,
                                          'Wrong password',
                                        );
                                      } else {
                                        await showErrorDialog(
                                          context,
                                          'Error: ${e.code}',
                                        );
                                      }
                                    } catch (e) {
                                      await showErrorDialog(
                                        context,
                                        e.toString(),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Login',
                                    textAlign: TextAlign.center,
                                    style: style.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      registerRoute,
                                      (route) => false,
                                    );
                                  },
                                  child: const Text(
                                      'Not Register yet? \n   Register Here'))
                            ],
                          );
                        default:
                          return const Text('Loading...');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
