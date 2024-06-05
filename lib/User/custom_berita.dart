import 'package:flutter/material.dart';
import 'color.dart' as color;

class CustomBerita extends StatelessWidget {
  final String title;
  final String gambar;
  final String tahun;
  final String deskripsi;

  const CustomBerita({
    Key? key,
    required this.title,
    required this.gambar,
    required this.tahun,
    required this.deskripsi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showCustomDialog(context, title, gambar, tahun),
      child: Container(
        height: 135,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(gambar), fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: color.AppColor.putihPucat),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(
                        tahun,
                        style: TextStyle(color: color.AppColor.putihPucat),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFFeaeefc),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Berita",
                        style: TextStyle(color: Color(0xFF839fed)),
                      ),
                    )),
                Row(
                  children: [
                    for (int i = 0; i < 70; i++)
                      i.isEven
                          ? Container(
                              width: 3,
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Color(0xFF839fed),
                                  borderRadius: BorderRadius.circular(2)))
                          : Container(
                              width: 3,
                              height: 1,
                              color: Colors.white,
                            )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showCustomDialog(
      BuildContext context, String title, String gambar, String tahun) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top:
                          10), // Sesuaikan dengan jumlah padding atas yang diinginkan
                  child: Align(
                    alignment: Alignment(
                        0.9, 0.2), // Sesuaikan nilai x dan y sesuai keinginan
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors
                            .grey, // Sesuaikan dengan warna latar belakang yang diinginkan
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close, color: color.AppColor.hitam),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 330,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(gambar), // Path to your image
                      fit: BoxFit
                          .contain, // Ensure the entire image is visible without cropping
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -25, // Menggeser konten ke atas sebesar 20
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: color.AppColor.hitam,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Tahun: $tahun',
                                    style: TextStyle(
                                      color: color.AppColor.abupucat,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  deskripsi,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
