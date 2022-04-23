// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:assignment/api/online_work.dart';
import 'package:assignment/constants.dart';
import 'package:assignment/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../user/user_model.dart';

OnlineWork onlineWork = OnlineWork();

class UserPage extends StatefulWidget {
  User? user;
  UserPage({this.user, Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool show = false;
  final List<String> genderOptions = ['male', 'female', 'other'];
  final List<String> statusOptions = ['active', 'inactive'];

  late TextEditingController _name;
  late TextEditingController _email;
  late String? selectedGender;
  late String? selectedStatus;

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();

    if (widget.user != null) {
      _name.text = widget.user!.name;
      _email.text = widget.user!.email;
      selectedGender = widget.user!.gender;
      selectedStatus = widget.user!.status;
    }

    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  void validate() async {
    if (_email.text.isEmpty ||
        _email.text.isEmpty ||
        selectedGender == null ||
        selectedStatus == null) {
      await showErrorDialog(
        context: context,
        text: "Please select all things properly",
        buttonColor: kmycolor,
      );
      return;
    }

    setState(() {
      show = true;
    });

    if (widget.user == null) {
      Map<String, String> m = {
        "name": _name.text,
        "email": _email.text,
        "gender": selectedGender!,
        "status": selectedStatus!,
      };
      bool success = await onlineWork.createUser(m);
      setState(() {
        show = false;
      });

      if (success) {
        await showGenericDialog(
          context: context,
          title: "Success",
          content: "User Created Successfully",
          optionBuilder: () {
            return {
              "OK": true,
            };
          },
          buttonColor: kmycolor,
        );
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.id, (route) => false);
      } else {
        await showErrorDialog(
          context: context,
          text: "Email is already used!",
          buttonColor: kmycolor,
        );
      }
    } else {
      Map<String, String> m = {
        "name": _name.text,
        "email": _email.text,
        "gender": selectedGender!,
        "status": selectedStatus!,
      };
      bool success = await onlineWork.updateUser(m, widget.user!.id.toString());
      setState(() {
        show = false;
      });
      if (success) {
        await showGenericDialog(
          context: context,
          title: "Success",
          content: "User Updated Successfully",
          optionBuilder: () {
            return {
              "OK": true,
            };
          },
          buttonColor: kmycolor,
        );
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.id, (route) => false);
      } else {
        await showErrorDialog(
          context: context,
          text: "Oops! Something went wrong",
          buttonColor: kmycolor,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.user == null
            ? const Text("Add User")
            : const Text("Update User"),
        backgroundColor: Colors.purple[900],
      ),
      body: ModalProgressHUD(
        inAsyncCall: show,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                NormalTextField(
                  controller: _name,
                  inputType: TextInputType.name,
                  labelText: "Name",
                  validator: null,
                ),
                const SizedBox(
                  height: 10,
                ),
                NormalTextField(
                  controller: _email,
                  inputType: TextInputType.emailAddress,
                  labelText: "Email",
                  validator: null,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormBuilderDropdown(
                  name: 'gender',
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onChanged: (gen) {
                    setState(() {
                      selectedGender = gen as String;
                    });
                  },
                  initialValue: widget.user != null ? selectedGender : null,
                  hint: const Text('Select Gender'),
                  items: genderOptions
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                FormBuilderDropdown(
                  name: 'status',
                  decoration: InputDecoration(
                    labelText: 'Status',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onChanged: (status) {
                    setState(() {
                      selectedStatus = status as String;
                    });
                  },
                  initialValue: widget.user != null ? selectedStatus : null,
                  hint: const Text('Select Status'),
                  items: statusOptions
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyButton(
                  onPress: validate,
                  text: widget.user == null ? "Add" : "Update",
                  normal: true,
                  context: context,
                  buttonColor: kmycolor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
