import 'package:flutter/material.dart';

TextStyle header(BuildContext context) => TextStyle(
    color: Theme.of(context).colorScheme.primary,
    fontWeight: FontWeight.bold,
    fontSize: 30);

TextStyle subtitle({Color? color}) => TextStyle(fontSize: 15, color: color);

InputDecoration textInput(BuildContext context, String placeholderLabel) =>
    InputDecoration(
        fillColor: Theme.of(context).colorScheme.primary,
        labelText: placeholderLabel,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 1.5),
            borderRadius: BorderRadius.circular(13)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 1.5),
            borderRadius: BorderRadius.circular(13)));

ButtonStyle button(BuildContext context, bool isLoading) => ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    backgroundColor: MaterialStateColor.resolveWith((states) => isLoading
        ? Colors.blue.shade100
        : states.contains(MaterialState.pressed)
            ? Color.fromARGB(255, 116, 193, 255)
            : Theme.of(context).colorScheme.primary),
    textStyle: MaterialStateTextStyle.resolveWith(
        (states) => TextStyle(fontSize: 17, color: Colors.white)));


ButtonStyle registrationButton(BuildContext context, bool isLoading, bool isDisable) => ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    backgroundColor: MaterialStateColor.resolveWith((states) => isLoading
        ? Colors.blue.shade100
        : isDisable ? Colors.grey.shade400 : states.contains(MaterialState.pressed)
            ? Color.fromARGB(255, 116, 193, 255)
            : Theme.of(context).colorScheme.primary),
    textStyle: MaterialStateTextStyle.resolveWith(
        (states) => TextStyle(fontSize: 17, color: Colors.white)));

Widget checkBox(BuildContext context, bool value) => Container(
      padding: EdgeInsets.all(5),
      child: value
          ? Icon(Icons.check_box,
              size: 25, color: Theme.of(context).colorScheme.primary)
          : Icon(Icons.square, size: 25, color: Colors.grey.shade400),
    );
