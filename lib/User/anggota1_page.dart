import 'package:flutter/material.dart';
import 'profil1_page.dart'; // Import halaman profil

class Anggota1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cabang 2'),
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
              label: 'Profile'),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
              child: Image.asset(
            'assets/back.jpg',
            fit: BoxFit.cover,
          )),
          SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Data Anggota Cabang 2',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Data Marga Sinaga yang tercantum dalam tabel merupakan daftar anggota Cabang 1 dari Punguan Marga Sinaga. Mereka berasal dari berbagai sektor dan regional yang berbeda di dalam organisasi. Daftar ini mencakup nama anggota beserta nomor identifikasi mereka.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20.0, // Jarak antar kolom
                    horizontalMargin: 10.0, // Margin horizontal
                    columns: [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Nama')),
                      DataColumn(label: Text('Sektor')),
                      DataColumn(label: Text('Regional')),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('1')),
                        DataCell(TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Profile1Page(name: 'Syahrial Sinaga'),
                              ),
                            );
                          },
                          child: Text('Syahrial Sinaga'),
                        )),
                        DataCell(Text('Sektor A')),
                        DataCell(Text('Regional X')),
                      ]),
                      // Lakukan hal yang sama untuk nama anggota lainnya
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
