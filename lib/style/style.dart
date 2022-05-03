import 'package:flutter/material.dart';

TextStyle header(BuildContext context) => TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 30);

TextStyle subtitle({Color? color}) => TextStyle(
  fontSize: 15,
  color: color
);

InputDecoration textInput (BuildContext context, String placeholderLabel) => InputDecoration(
  fillColor: Theme.of(context).colorScheme.primary,
  labelText: placeholderLabel,
  labelStyle: TextStyle(
    color: Theme.of(context).colorScheme.primary
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),

    borderRadius: BorderRadius.circular(13)
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
    borderRadius: BorderRadius.circular(13)
  )
);

ButtonStyle button(BuildContext context) => ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10)
  )),
  backgroundColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.pressed)? Color.fromARGB(255, 116, 193, 255) : Theme.of(context).colorScheme.primary),
 textStyle: MaterialStateTextStyle.resolveWith((states) => TextStyle(fontSize: 17, color: Colors.white))
);