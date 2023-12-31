import 'package:flutter/material.dart';
import 'package:snapcrate/service/auth_service.dart';
import 'package:get/get.dart';
import 'package:snapcrate/widgets/form_inputbox.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/registerScreen";
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authManager = Get.find();
  bool _passValidated = false;

  incrementCounter(flag) {
    setState(() {
      _passValidated = flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: ((context, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 300,
                      /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                      child:
                          const Image(image: AssetImage("assets/camera.png"))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 15),
                child: TextField(
                  controller: _userController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'user',
                      hintText: 'enter your unique user name'),
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
              PasswordField(
                validationController: incrementCounter,
                textController: _passwordController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: _passValidated
                      ? () {
                          _authManager.register(_userController.text,
                              _emailController.text, _passwordController.text);
                        }
                      : null,
                  child: Container(
                    alignment: Alignment.center,
                    width: constraints.maxWidth * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 130,
              ),
            ],
          ),
        );
      })),
    );
  }
}
