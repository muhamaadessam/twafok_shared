import 'package:flutter/material.dart';

double heightRation(context, double height) =>
    MediaQuery.sizeOf(context).height * height / 800;

double widthRation(context, double width) =>
    MediaQuery.sizeOf(context).width * width / 360;
