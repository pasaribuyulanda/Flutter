import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditJabatanPage extends StatefulWidget {
  @override
  _EditJabatanPageState createState() => _EditJabatanPageState();
}

class _EditJabatanPageState extends State<EditJabatanPage> {
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Data Jabatan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 182, 34, 24),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () async {
                  final imagePicker = ImagePicker();
                  final pickedFile =
                      await imagePicker.getImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _imagePath = pickedFile.path;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        size: 48.0,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        _imagePath == null ? 'Pilih Gambar' : 'Ubah Gambar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nama Jabatan',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildButton(
                    onPressed: () {
                      // Tambahkan logika untuk tombol Edit di sini
                    },
                    label: 'Edit',
                    color: Color.fromARGB(255, 17, 59, 136),
                    icon: Icons.edit,
                  ),
                ],
              ),
              SizedBox(height: 10),
              DataTable(
                columnSpacing: 20.0,
                horizontalMargin: 10.0,
                dataRowHeight: 40.0,
                columns: [
                  DataColumn(
                    label: SizedBox(width: 150.0, child: Text('Gambar')),
                  ),
                  DataColumn(
                    label: SizedBox(width: 150.0, child: Text('Jabatan')),
                  ),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(
                      _imagePath != null
                          ? Text(_imagePath!, textAlign: TextAlign.left)
                          : Text('Belum dipilih', textAlign: TextAlign.left),
                    ),
                    DataCell(
                      Text('Sektor A', textAlign: TextAlign.left),
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
    required String label,
    required Color color,
    required IconData icon,
  }) {
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
