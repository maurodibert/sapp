import 'package:flutter/material.dart';

// COLORS
// Primary Palette
const kYellow = Color(0xFFFFC70D);
const kOrangeAccent = Color(0xFFF89F00);

// General Palette
const kError = Color(0xFFF64949);
const kSuccess = Color(0xFF3BD5A9);
const kInfo = Color(0xFF2799F9);
const kWarning = Color(0xFFFFC95C);

//
// LAYOUT
const SizedBox k8Vertical = SizedBox(height: 8);
const SizedBox k16Vertical = SizedBox(height: 16);
const SizedBox k24Vertical = SizedBox(height: 24);
const SizedBox k32Vertical = SizedBox(height: 32);
const SizedBox k48Vertical = SizedBox(height: 48);
const SizedBox k56Vertical = SizedBox(height: 56);
const SizedBox k80Vertical = SizedBox(height: 80);

const SizedBox k8Horizontal = SizedBox(width: 8);
const SizedBox k16Horizontal = SizedBox(width: 16);
const SizedBox k24Horizontal = SizedBox(width: 24);
const SizedBox k62Horizontal = SizedBox(width: 62);

//
// COMPONENTS - general
BoxShadow kBottomMediumShadow = BoxShadow(
  offset: Offset(0, 12),
  blurRadius: 15,
  spreadRadius: 2,
  color: Colors.black45,
);

double kBigRadius = 40;
double kMediumRadius = 16;
double kSmallRadius = 10;

//
// FONTS - General
TextStyle kH1 = TextStyle(
    fontFamily: "Noto Sans",
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: Colors.black);

TextStyle kH2 = TextStyle(
    fontFamily: "Noto Sans",
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Colors.black);

TextStyle kH3 = TextStyle(
    fontFamily: "Noto Sans",
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.black);

TextStyle kP = TextStyle(
    fontFamily: "Noto Sans",
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black);

TextStyle kSmall = TextStyle(
    fontFamily: "Noto Sans",
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black);

TextStyle kMicro = TextStyle(
    fontFamily: "Noto Sans",
    fontSize: 8,
    fontWeight: FontWeight.w400,
    color: Colors.black);
