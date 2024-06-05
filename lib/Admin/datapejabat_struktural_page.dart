import 'package:flutter/material.dart';
import 'edit_pejabat_struktural_page.dart'; // Import halaman EditCabangPage

class DataAnggotaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Anggota',
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
              DataTable(
                columnSpacing: 2.0, // Mengurangi jarak antar kolom
                horizontalMargin: 2.0, // Margin horizontal
                dataRowHeight: 70.0, // Tinggi baris tabel
                columns: [
                  DataColumn(label: SizedBox(width: 30.0, child: Text('No'))),
                  DataColumn(label: SizedBox(width: 70.0, child: Text('Nama'))),
                  DataColumn(
                      label: SizedBox(width: 70.0, child: Text('Sektor'))),
                  DataColumn(
                      label: SizedBox(
                          width: 120.0,
                          child:
                              Text('Aksi'))), // Kolom aksi ditambahkan di sini
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('1', textAlign: TextAlign.center)),
                    DataCell(
                        Text('Yulanda Pasaribu', textAlign: TextAlign.left)),
                    DataCell(Text('Sektor A', textAlign: TextAlign.left)),
                    DataCell(
                      Row(
                        children: [
                          _buildButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditPejabatStrukturalPage(),
                                ),
                              );
                            },
                            color: Color.fromARGB(255, 19, 79, 189),
                            icon: Icons.edit,
                            tooltip: 'Edit',
                          ),
                        ],
                      ),
                    ),
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

  Widget _buildButton({
    required VoidCallback onPressed,
    required Color color,
    required IconData icon,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 32.0, // Ubah ukuran lebar tombol di sini
        height: 32.0, // Ubah ukuran tinggi tombol di sini
        child: InkWell(
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Icon(icon,
                  size: 16, color: Colors.white), // Ubah ukuran ikon di sini
            ),
          ),
        ),
      ),
    );
  }
}
