import 'package:flutter/material.dart';
import 'package:pptsb/User/color.dart' as color;

class SekretarisTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: color.AppDecoration.backgroundImageDecoration,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 12.0),
              width: 300,
              height: 300,
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/old-man.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                margin: EdgeInsets.only(top: 15, right: 180),
                child: Text(
                  "Prof. Ardilles Sianaga",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  width: 130,
                  height: 25,
                  margin: EdgeInsets.only(right: 245),
                  decoration: BoxDecoration(
                    color: color.AppColor.boxBerita,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 247,
                  bottom: 0,
                  child: Center(
                    child: Text(
                      "Sekretaris Organisasi",
                      style: TextStyle(
                          fontSize: 10,
                          color: color.AppColor.putihPucat,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 232),
                  child: Text("Detail Informasi",
                      style: TextStyle(
                          fontSize: 20,
                          color: color.AppColor.hitam,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                            color: color.AppColor
                                .abupucat, // sesuaikan dengan warna yang benar
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                "Lahir di negara konoha dengan status berkeluarga dan menjabat sebagai ketua selama 4 tahun dan berstatus ketua pada organisasi ini yang membina dengan  baik keutuhan organisasi",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: color.AppColor.hitam,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      )),
                )
              ],
            )
          ],
        ));
  }
}
