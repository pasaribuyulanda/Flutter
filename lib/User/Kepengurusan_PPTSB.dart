import 'package:flutter/material.dart';
import 'package:pptsb/User/Utils/InformasiBPH.dart';
import 'package:pptsb/User/tab/Bendahara_Tab.dart';
import 'package:pptsb/User/tab/Ketua_Tab.dart';
import 'package:pptsb/User/tab/Sekretaris_Tab.dart';
import 'package:pptsb/User/tab/WakilKetua_Tab.dart';
import 'color.dart' as color;

class KepengurusanPPTSB extends StatelessWidget {
  const KepengurusanPPTSB({Key? key});

  @override
  Widget build(BuildContext context) {
    //my Tabs
    List<Widget> myTabs = [
      //Ketua
      InformasiBPH(
        pathGambar: 'assets/man1.png',
        judul: 'Ketua',
      ),

      //Wakil Ketua
      InformasiBPH(
        pathGambar: 'assets/man2.png',
        judul: 'Wakil Ketua',
      ),

      //Sekretaris
      InformasiBPH(
        pathGambar: 'assets/old-man.png',
        judul: 'Sekretaris',
      ),

      //Bendahara
      InformasiBPH(
        pathGambar: 'assets/woman1.png',
        judul: 'Bendahara',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red, // Menambahkan warna merah di sini
        title: Text(
          'Data Kepengurusan PPTSB',
          style: TextStyle(
              color: color.AppColor.putihPucat, fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // Mengatur teks agar berada di tengah
        iconTheme: IconThemeData(
          color: Colors.white, // Mengatur warna ikon menjadi putih
        ),
      ),
      body: DefaultTabController(
        length: myTabs.length,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/back.jpg'), fit: BoxFit.fill)),
          child: Column(
            children: [
              //Data Kepengurusan PPTSB

              SizedBox(
                height: 24,
              ),

              //Tab Bar
              TabBar(tabs: myTabs),

              //Tab Bar View
              Expanded(
                  child: TabBarView(children: [
                // Ketua Page
                KetuaTab(),

                //Wakil Ketua Page
                WakilKetuaTab(),

                //Sekretaris Page
                SekretarisTab(),

                //Bendahara Page
                BendaharaTab(),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
