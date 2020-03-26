import 'package:flutter/material.dart';

const textFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.black),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black,width: 2)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue,width: 2)
  ),
);