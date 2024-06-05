import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pptsb/User/custom_berita.dart';
import 'color.dart' as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({super.key});

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  final List<Map<String, dynamic>> cardBerita = [
    {
      'title': 'Aku Di kubur Hidup-Hidup',
      'gambar': 'assets/miaw1.png',
      'tahun': '2024',
      'deskripsi':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque euismod, nisi eu consectetur consectetur, nisi nisi consectetur nisi, euismod nisi nisi euismod nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    },
    {
      'title': 'Masuk Ke Rumah Sakit Jiwa',
      'gambar': 'assets/miaw2.png',
      'tahun': '2024',
      'deskripsi':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque euismod, nisi eu consectetur consectetur, nisi nisi consectetur nisi, euismod nisi nisi euismod nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    },
    {
      'title': 'Diserang WereWolf',
      'gambar': 'assets/miaw3.png',
      'tahun': '2024',
      'deskripsi':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque euismod, nisi eu consectetur consectetur, nisi nisi consectetur nisi, euismod nisi nisi euismod nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    },
    {
      'title': 'Seram Banget Ini Game',
      'gambar': 'assets/miaw4.png',
      'tahun': '2024',
      'deskripsi':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque euismod, nisi eu consectetur consectetur, nisi nisi consectetur nisi, euismod nisi nisi euismod nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    },
  ];

  bool _playArea = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/back.jpg'), fit: BoxFit.fill)),
              padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: color.AppColor.hitam,
                        ),
                      ),
                      Text("Home",
                          style: TextStyle(
                              fontSize: 15,
                              color: color.AppColor.hitam,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Berita PPTSB",
                        style: TextStyle(
                            fontSize: 25,
                            color: color.AppColor.hitam,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Silahkan mengunjungi ke berita terbaru yang anda inginkan mengenai Pomparan Parsadaan Toga Sinaga Dohot Boru untuk informasi terkini dan perkembangan terbaru.",
                        style: TextStyle(
                            fontSize: 15, color: color.AppColor.hitam),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: color.AppColor.merahMerona,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(70))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Expanded(child: _listView()),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _listView() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      itemCount: cardBerita.length > 4 ? 4 : cardBerita.length,
      itemBuilder: (context, index) {
        final Map<String, dynamic> data = cardBerita[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10), // Mengurangi padding horizontal
          child: CustomBerita(
            key: UniqueKey(),
            title: data['title'],
            gambar: data['gambar'],
            tahun: data['tahun'],
            deskripsi: data['deskripsi'],
          ),
        );
      },
    );
  }
}
