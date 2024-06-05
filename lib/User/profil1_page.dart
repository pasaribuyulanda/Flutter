import 'package:flutter/material.dart';

class Profile1Page extends StatelessWidget {
  final String name;

  Profile1Page({required this.name});

  @override
  Widget build(BuildContext context) {
    // Contoh data profil untuk anggota
    String statusKeluarga = "Kepala Keluarga";
    String namaIstri = "Istri $name";
    int jumlahAnak = 2;
    List<String> namaAnak = ["Andre Sinaga", "Elsa Sinaga"];
    List<String> fotoPrestasiAnak = [
      "prestasi_anak1.jpg",
      "prestasi_anak2.jpg"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil $name'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto anggota dan data
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                        'syahrial.jpg'), // Ganti dengan foto anggota yang sesuai
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nama: $name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Status Keluarga: $statusKeluarga',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Nama Istri: $namaIstri',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Jumlah Anak: $jumlahAnak',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            // Tabel data anak
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Nama Anak:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  for (String anak in namaAnak)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_right),
                          SizedBox(width: 10),
                          Text(
                            anak,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            // Foto prestasi anak
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prestasi Anak:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  for (int i = 0; i < fotoPrestasiAnak.length; i++)
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(fotoPrestasiAnak[
                              i]), // Ganti dengan foto prestasi anak yang sesuai
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Penjelasan Foto Prestasi Anak $i: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus accumsan, lorem nec ultrices feugiat, ligula dui hendrerit mauris, id fermentum dolor neque ac nisi.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
