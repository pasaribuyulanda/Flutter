import 'package:flutter/material.dart';
import 'package:pptsb/User/color.dart' as color;

class InformasiBPH extends StatelessWidget {
  final String pathGambar;
  final String judul;

  const InformasiBPH(
      {super.key, required this.pathGambar, required this.judul});

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 95,
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: color.AppColor.merahMerona,
                  borderRadius: BorderRadius.circular(12)),
              child: Image.asset(pathGambar),
            ),
            SizedBox(height: 5),
            Text(
              judul,
              style: TextStyle(
                fontSize: 10,
                color: const Color.fromARGB(255, 0, 0, 0), // Warna teks putih
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Mengatur teks agar berada di tengah
            ),
          ],
        ),
      ),
    );
  }
}
