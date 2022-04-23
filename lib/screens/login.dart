import 'package:assignment/screens/homepage.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String id = "login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _username;
  late final TextEditingController _password;

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
        ),
        backgroundColor: Colors.purple[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              NormalTextField(
                controller: _username,
                inputType: TextInputType.emailAddress,
                labelText: "Username",
                validator: null,
              ),
              const SizedBox(
                height: 10,
              ),
              NormalTextField(
                controller: _password,
                inputType: TextInputType.visiblePassword,
                labelText: "Password",
                validator: null,
              ),
              const SizedBox(
                height: 10,
              ),
              MyButton(
                onPress: () async {
                  if (_username.text.isEmpty || _password.text.isEmpty) {
                    await showErrorDialog(
                      context: context,
                      text: "Please enter username and password",
                      buttonColor: kmycolor,
                    );
                    return;
                  }

                  if (_username.text == "admin" && _password.text == "admin") {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomePage.id, (route) => false);
                  } else {
                    await showErrorDialog(
                      context: context,
                      text: "Wrong username and/or password",
                      buttonColor: kmycolor,
                    );
                  }
                },
                text: "Login",
                normal: true,
                context: context,
                buttonColor: kmycolor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
