import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/routes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 30),
              child: SvgPicture.asset(
                'assets/lettutor_logo.svg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(164, 176, 190, 1),
                      ),
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.mail, size: 26, color: Color(0xFF0058C6)),
                      hintText: 'mail@example.com',
                      hintStyle: TextStyle(
                        color: Color(0xFFB0B0B0),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFB0B0B0)),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    child: const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(164, 176, 190, 1),
                      ),
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.lock, size: 26, color: Color(0xFF0058C6)),
                      hintText: '*****',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(top: 20, bottom: 15),
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Routes.navigateToReplacement(context, Routes.home);
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 16),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF0058C6)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text('Login',
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 30, bottom: 10),
                    child: const Text(
                      'Or continue with',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/facebook-logo.svg',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/google-logo.svg',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/facebook-logo.svg',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member yet?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          )),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Sign Up',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
