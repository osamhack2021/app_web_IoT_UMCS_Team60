import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ucms/theme/color_theme.dart';

TextStyle h1({bold =true}) => GoogleFonts.jua(fontSize : 30, fontWeight : bold?FontWeight.bold:FontWeight.normal, color: mainTextColor());
TextStyle h2({bold =true}) => GoogleFonts.jua(fontSize : 25, fontWeight : bold?FontWeight.bold:FontWeight.normal, color: mainTextColor());
TextStyle h3({bold =true}) => GoogleFonts.jua(fontSize : 20, color: mainTextColor());

TextStyle warning({bold =true}) =>GoogleFonts.jua(fontSize : 15, fontWeight : bold?FontWeight.bold:FontWeight.normal, color: Colors.red.shade400);

TextStyle bold({fontSize=20,bold =true}) => GoogleFonts.jua(fontSize : fontSize, fontWeight: FontWeight.bold, color: mainTextColor());

TextStyle body({fontSize=20,bold =true}) => GoogleFonts.jua(fontSize : fontSize, fontWeight : bold?FontWeight.bold:FontWeight.normal, color: mainTextColor());

TextStyle small({fontSize=10,bold =true}) => GoogleFonts.jua(fontSize : fontSize,fontWeight : bold?FontWeight.bold:FontWeight.normal, color: mainTextColor());

TextStyle footerStyle({fontSize=10}) => GoogleFonts.nanumGothic(fontSize : fontSize, color: footerTextColor());

