import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  static Color homePageBackground = const Color(0xFFfbfcff);

  static Color abupucat = Color.fromARGB(255, 185, 186, 188);
  
  static Color abusemi = Color.fromARGB(255, 227, 227, 230);

  static Color merahMerona =Color(0xFFC0210B); // warna background temukan informasi sekarang

  static Color merahTerang =Color.fromARGB(255, 227, 64, 43); // warna background temukan informasi sekarang

  static Color warnaNotifikasi = Color(0xFFC0210B); // warna background notifikasi

  static Color bayanganPutih =  Color.fromRGBO(238, 234, 234, 1); // warna bayangan setiap card

  static Color button = Color.fromRGBO(238, 38, 12, 0.969);

  static Color boxBerita = Color.fromARGB(255, 188, 33, 12);

  static Color warnaRegional =Color.fromRGBO(242, 31, 31, 0.968); // warna data regional di halam pusat

  static Color warnaCabang =Color.fromRGBO(4, 149, 18, 0.882); // warna data regional di halam pusat

  static Color warnaAnggota =Color.fromRGBO(148, 0, 15, 0.933); // warna data regional di halam pusat

  static Color warnaSektor =Color.fromRGBO(3, 183, 215, 1); // warna data regional di halam pusat

  static Color hitam =Color.fromARGB(255, 0, 0, 0); // warna data nggota di halaman pusat

  static Color homePageContainerTextSmall =Color.fromRGBO(123, 214, 31, 1); // warna data nggota di halaman pusat

  static Color homePageContainerTextBig =Color.fromRGBO(47, 184, 42, 1); // warna data nggota di halaman pusat

  static Color putihPucat = const Color(0xFFfefeff);

}

class AppDecoration {
  static BoxDecoration backgroundImageDecoration = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/back.jpg'),
      fit: BoxFit.fill,
    ),
  );

  // Tambahkan dekorasi lainnya sesuai kebutuhan aplikasi kamu
}