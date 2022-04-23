import 'package:assignment/constants.dart';
import 'package:assignment/user/user_model.dart';
import 'package:flutter/material.dart';

class UserView extends StatefulWidget {
  final User user;
  const UserView({required this.user, Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late final TextEditingController _id, _name, _email, _gender, _status;

  @override
  void initState() {
    super.initState();
    _id = TextEditingController();
    _name = TextEditingController();
    _email = TextEditingController();
    _gender = TextEditingController();
    _status = TextEditingController();

    _id.text = widget.user.id.toString();
    _email.text = widget.user.email;
    _name.text = widget.user.name;
    _gender.text = widget.user.gender;
    _status.text = widget.user.status;
  }

  @override
  void dispose() {
    super.dispose();
    _id.dispose();
    _name.dispose();
    _email.dispose();
    _gender.dispose();
    _status.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildMyField(String label, IconData icon, TextEditingController c) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              fontSize: 25,
              color: Colors.lightBlue,
            ),
            prefixIcon: Icon(
              icon,
              size: 25,
              color: kmycolor,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.purple,
                width: 3,
              ),
            ),
          ),
          controller: c,
          readOnly: true,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Details",
        ),
        backgroundColor: Colors.purple[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            buildMyField("ID", Icons.numbers, _id),
            buildMyField("Name", Icons.person, _name),
            buildMyField("Email", Icons.email, _email),
            buildMyField(
              "Gender",
              widget.user.gender == "male" ? Icons.male : Icons.female,
              _gender,
            ),
            buildMyField("Status", Icons.done_all, _status),
          ],
        ),
      ),
    );
  }
}
