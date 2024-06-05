import 'package:flutter/material.dart';
import 'package:pptsb/Admin/datapusat_page.dart';
import 'package:pptsb/User/home_page_user.dart';
import 'package:pptsb/Admin/enter_code_page.dart';
import 'package:pptsb/Admin/registrasiAnggota.dart';
import 'package:pptsb/Admin/dataregional_page.dart';
import 'package:pptsb/Admin/datasektor_page.dart';
import 'package:pptsb/Admin/datacabang_page.dart';
import 'package:pptsb/Admin/dataanggota_page.dart';
import 'package:pptsb/Admin/datajabatan_page.dart';
import 'package:pptsb/Admin/databeasiswa.dart';
import 'package:pptsb/User/register_form.dart';
import 'package:pptsb/login_form.dart';
import 'package:pptsb/register_code_page.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) =>
            LoginPage(), // Gunakan LoginForm sebagai widget untuk rute '/'
        '/home': (context) => HomePageUser(),
        '/dataPusat': (context) => DataPusatPage(),
        '/dataRegional': (context) => DataRegionalPage(),
        '/dataSektor': (context) => DataSektorPage(),
        '/dataCabang': (context) => DataCabangPage(),
        '/dataAnggota': (context) => DataAnggotaPage(),
        '/dataJabatan': (context) => DataJabatanPage(),
        '/dataBeasiswa': (context) => BeasiswaPage(),
        '/register': (context) => RegisterForm(),

        '/registrasiAnggota': (context) => RegistrasiAnggotaPage(),
        '/enter_code': (context) => EnterCodePage(),
        '/signup': (context) => SignupPage(
              firstName: '',
              lastName: '',
              email: '',
            ),
      },
      initialRoute: '/',
    );
  }
}
