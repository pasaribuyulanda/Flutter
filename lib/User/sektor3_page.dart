import 'package:flutter/material.dart';

class Sektor3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sektor 3'),
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
                  'Data Anggota Sektor 3',
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
                        DataCell(Text('Yulanda Pasaribu')),
                        DataCell(Text('Sektor A')),
                        DataCell(Text('Regional X')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('2')),
                        DataCell(Text('Vlen Simanjuntak')),
                        DataCell(Text('Sektor B')),
                        DataCell(Text('Regional Y')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('3')),
                        DataCell(Text('Juan Sihombing')),
                        DataCell(Text('Sektor B')),
                        DataCell(Text('Regional Y')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('4')),
                        DataCell(Text('Erichson Berutu')),
                        DataCell(Text('Sektor B')),
                        DataCell(Text('Regional Y')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('5')),
                        DataCell(Text('Arta Sitorus')),
                        DataCell(Text('Sektor B')),
                        DataCell(Text('Regional Y')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('6')),
                        DataCell(Text('Diva Napitupulu')),
                        DataCell(Text('Sektor B')),
                        DataCell(Text('Regional Y')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('7')),
                        DataCell(Text('David Silalahi')),
                        DataCell(Text('Sektor B')),
                        DataCell(Text('Regional Y')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('8')),
                        DataCell(Text('Benyamin Sibarani')),
                        DataCell(Text('Sektor B')),
                        DataCell(Text('Regional Y')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('9')),
                        DataCell(Text('Mega Malau')),
                        DataCell(Text('Sektor B')),
                        DataCell(Text('Regional Y')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('10')),
                        DataCell(Text('Rivael Sagala')),
                        DataCell(Text('Sektor B')),
                        DataCell(Text('Regional Y')),
                      ]),
                      // Tambahkan baris data lainnya di sini sesuai kebutuhan
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
