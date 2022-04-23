// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

const kmycolor = Color(0xff7F3DFF);
const kbtncolor = Color(0xffEEE5FF);
const ktextcolor = Color(0xff91919F);
const kgreen = Color(0xff00A86B);
const kred = Color(0xffFD3C4A);
const kicon = Color(0xffC6C6C6);

class MyButton extends StatelessWidget {
  final Function() onPress;
  final String text;
  Color? buttonColor = Colors.lightBlueAccent;
  Color? textColor = Colors.white;
  final bool normal;
  final BuildContext context;

  MyButton({
    Key? key,
    required this.onPress,
    this.buttonColor,
    this.textColor,
    required this.text,
    required this.normal,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      shape: const StadiumBorder(),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      height: 40,
      minWidth: normal ? double.infinity : null,
      textColor: Colors.white,
      color: buttonColor,
    );
  }
}

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionBuilder,
  Color? buttonColor,
  Color? textColor,
}) {
  final options = optionBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((optionTile) {
          final value = options[optionTile];
          return MyButton(
            onPress: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            text: optionTile,
            normal: true,
            context: context,
            buttonColor: buttonColor,
            textColor: textColor,
          );
        }).toList(),
      );
    },
  );
}

Future<void> showErrorDialog({
  required BuildContext context,
  required String text,
  Color? buttonColor,
  Color? textColor,
}) {
  return showGenericDialog(
    context: context,
    title: "An Error Occured",
    content: text,
    optionBuilder: () {
      return {
        'OK': null,
      };
    },
    buttonColor: buttonColor,
    textColor: textColor,
  );
}

class NormalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  const NormalTextField({
    Key? key,
    required this.controller,
    required this.inputType,
    required this.labelText,
    required this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autocorrect: false,
      obscureText: labelText == "Password" ? true : false,
      keyboardType: inputType,
      style: const TextStyle(
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      maxLines: inputType == TextInputType.multiline ? 6 : 1,
      minLines: inputType == TextInputType.multiline ? 3 : 1,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.purple[900],
          fontSize: 18,
        ),
        fillColor: Colors.grey,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purple, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
