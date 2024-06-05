import 'package:flutter/material.dart';
import 'package:pptsb/User/cabang_page.dart';
import 'package:pptsb/User/pusat_page.dart';
import 'package:pptsb/User/regional_page.dart';
import 'package:pptsb/User/sektor_page.dart';
import 'color.dart' as color;

class CustomCard extends StatelessWidget {
  final String title;
  final String infoA;
  final String infoB;
  final String imagePath;

  const CustomCard({
    required Key key, 
    required this.title,
    required this.infoA,
    required this.infoB,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 20),
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: color.AppColor.hitam,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(3, 3),
                  color: color.AppColor
                      .bayanganPutih, // sesuaikan dengan warna yang benar
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 300,
            margin: const EdgeInsets.only(left: 25, top: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: infoA,
                        style: TextStyle(
                          color: color.AppColor.hitam,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                          text:
                              '\n'), // Tambahkan baris baru di antara dua teks
                      TextSpan(
                        text: infoB,
                        style: TextStyle(
                          color: color.AppColor.hitam,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                    height:
                        10), // Tambahkan jarak antara informasi B dan button
                ElevatedButton(
                  onPressed: () {
                    switch (title) {
                      case 'Pusat':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PusatPage()),
                        );
                        break;
                      case 'Regional':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegionalPage()),
                        );
                        break;
                      case 'Sektor':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SektorPage()),
                        );
                        break;
                      case 'Cabang':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CabangPage()),
                        );
                        break;
                      default:
                        // Handle jika tidak ada judul yang cocok
                        break;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFC0210B), // Warna teks button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  child: Text(
                    "Buka Sekarang",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ), // Tambahkan teks button
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 50, left: 255, bottom: 30),
              height: 105,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
