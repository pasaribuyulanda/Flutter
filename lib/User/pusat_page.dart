import 'package:flutter/material.dart';
import 'package:pptsb/User/pie_chart.dart'; // Pastikan path modul pie_chart sudah benar
import 'color.dart' as color;
import 'package:http/http.dart' as http;
import 'dart:convert';

class PusatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> getData() async {
      final response =
          await http.get(Uri.parse("http://127.0.0.1:8000/api/pusat"));
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Informasi Pusat PPTSB',
          style: TextStyle(
            color: color.AppColor.putihPucat,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Icon(Icons.account_circle),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/back.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                FutureBuilder<List<dynamic>>(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final list = snapshot.data!;
                      if (list.isEmpty) {
                        return Center(child: Text('No data available'));
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final pusat = list[index];
                            return ListTile(
                              title: Text(pusat['Nama_pusat']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Kode Pusat : ${pusat['Kode_pusat']}"),
                                  Text("Alamat: ${pusat['Alamat_pusat']}"),
                                  Text(
                                      "Nama Kepala Pusat: ${pusat['Nama_kepala_pusat']}"),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Deskripsi",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Pusat PPTSB adalah pusat kegiatan utama yang mengoordinasikan upaya pelestarian, pengembangan, dan promosi budaya, tradisi, dan nilai-nilai masyarakat Batak Toba. Sebagai titik pusat, Pusat PPTSB memimpin segala inisiatif yang bertujuan untuk memelihara warisan penting ini. Pusat PPTSB beralamat di GJJJ+WW2, Simpang Selayang, Kec. Medan Tuntungan, Kota Medan, Sumatera Utara 20131",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Data Anggota Perbagian",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 350,
                  height: 200,
                  margin: EdgeInsets.all(8),
                  child: MyPieChart(
                    data: [200, 40, 50, 20],
                    colors: [
                      color.AppColor.warnaAnggota,
                      color.AppColor.warnaCabang,
                      color.AppColor.warnaSektor,
                      color.AppColor.warnaRegional,
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: 100,
                      height: 60,
                      padding: EdgeInsets.all(8),
                      color: index == 0
                          ? color.AppColor.warnaAnggota
                          : index == 1
                              ? color.AppColor.warnaCabang
                              : index == 2
                                  ? color.AppColor.warnaSektor
                                  : color.AppColor.warnaRegional,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            index == 0
                                ? 'Anggota'
                                : index == 1
                                    ? 'Cabang'
                                    : index == 2
                                        ? 'Sektor'
                                        : 'Regional',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '${[200, 40, 50, 20][index]}%',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                _buildPhotoRow(
                  context,
                  "assets/dairi.jpg",
                  "Ini adalah deskripsi foto pertama yang menunjukkan ...",
                  "assets/pengurus.jpg",
                  "Ini adalah deskripsi foto kedua yang menunjukkan ...",
                ),
                SizedBox(height: 15),
                _buildPhotoRow(
                  context,
                  "assets/tarombo.jpg",
                  "Ini adalah deskripsi foto ketiga yang menunjukkan ...",
                  "assets/pengurus.jpg",
                  "Ini adalah deskripsi foto keempat yang menunjukkan ...",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoRow(BuildContext context, String image1, String desc1,
      String image2, String desc2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _buildPhotoWithDescription(context, image1, desc1),
          SizedBox(width: 10),
          _buildPhotoWithDescription(context, image2, desc2),
        ],
      ),
    );
  }

  Widget _buildPhotoWithDescription(
      BuildContext context, String image, String description) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Tambahkan logika navigasi atau tindakan lainnya di sini
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  image,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
