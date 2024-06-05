import 'package:flutter/material.dart';

class HapusSektorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hapus Data Sektor',
          style: TextStyle(color: Colors.white), // Set warna teks menjadi putih
        ),
        backgroundColor: const Color.fromARGB(255, 182, 34, 24),
        iconTheme: IconThemeData(
            color: Colors.white), // Mengatur warna ikon menjadi putih
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Telepon',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Mengatur posisi ke kanan
                children: [
                  _buildButton(
                    onPressed: () {
                      // Tambahkan logika untuk tombol Tambah di sini
                    },
                    label: 'Hapus',
                    color: Color.fromARGB(255, 190, 33, 25),
                    icon: Icons.delete,
                  ),
                ],
              ),
              SizedBox(height: 10),
              DataTable(
                columnSpacing: 20.0, // Jarak antar kolom
                horizontalMargin: 10.0, // Margin horizontal
                dataRowHeight: 40.0, // Tinggi baris tabel
                columns: [
                  DataColumn(label: SizedBox(width: 30.0, child: Text('No'))),
                  DataColumn(
                      label: SizedBox(width: 150.0, child: Text('Nama'))),
                  DataColumn(
                      label: SizedBox(width: 150.0, child: Text('Sektor'))),
                  DataColumn(
                      label: SizedBox(width: 150.0, child: Text('Regional'))),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('1', textAlign: TextAlign.center)),
                    DataCell(
                        Text('Yulanda Pasaribu', textAlign: TextAlign.left)),
                    DataCell(Text('Sektor A', textAlign: TextAlign.left)),
                    DataCell(Text('Regional X', textAlign: TextAlign.left)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2', textAlign: TextAlign.center)),
                    DataCell(
                        Text('Vlen Simanjuntak', textAlign: TextAlign.left)),
                    DataCell(Text('Sektor B', textAlign: TextAlign.left)),
                    DataCell(Text('Regional Y', textAlign: TextAlign.left)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3', textAlign: TextAlign.center)),
                    DataCell(Text('Juan Sihombing', textAlign: TextAlign.left)),
                    DataCell(Text('Sektor B', textAlign: TextAlign.left)),
                    DataCell(Text('Regional Y', textAlign: TextAlign.left)),
                  ]),
                  // Tambahkan baris data lainnya di sini sesuai kebutuhan
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      {required VoidCallback onPressed,
      required String label,
      required Color color,
      required IconData icon}) {
    return Container(
      width: 100.0,
      height: 60.0,
      child: InkWell(
        onTap: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: Colors.white),
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
