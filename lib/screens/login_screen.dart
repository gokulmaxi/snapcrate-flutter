import 'package:flutter/material.dart';
import 'package:snapcrate/screens/register_screen.dart';
import 'package:snapcrate/service/auth_service.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/loginScreen";
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authManager = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.1),
                  child: Center(
                    child: Container(
                      width: 500,
                      height: 500,
                      /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                      child: const Image(
                        image: AssetImage("assets/login-banner.png"),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: GestureDetector(
                    onTap: () {
                      _authManager.login(
                          _emailController.text, _passwordController.text);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: constraints.maxWidth * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                //TODO add gesture detector and navigate to register screen
                InkWell(
                    onTap: () {
                      Get.to(const RegisterScreen());
                    },
                    child: const Text('New User? Create Account'))
              ],
            ),
          );
        }),
      ),
    );
  }
}
