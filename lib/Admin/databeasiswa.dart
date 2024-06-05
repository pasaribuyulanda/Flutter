import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BeasiswaPage extends StatefulWidget {
  const BeasiswaPage({Key? key}) : super(key: key);

  @override
  _BeasiswaPageState createState() => _BeasiswaPageState();
}

class _BeasiswaPageState extends State<BeasiswaPage> {
  late Future<List<dynamic>> _getData;

  @override
  void initState() {
    _getData = getData();
    super.initState();
  }

  Future<List<dynamic>> getData() async {
    final response =
        await http.get(Uri.parse("http://127.0.0.1:8000/api/beasiswa"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _getData = getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Request Beasiswa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<dynamic>>(
          future: _getData,
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
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final beasiswa = list[index];
                    // Memeriksa apakah URL gambar tersedia
                    bool isImageAvailable =
                        beasiswa['foto_nilai_rapor'] != null &&
                            beasiswa['foto_nilai_rapor'] != '';
                    return Card(
                      margin: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama : ${beasiswa['nama']}',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Logika untuk menolak beasiswa
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Text(
                                          'Tolak',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    GestureDetector(
                                      onTap: () {
                                        // Logika untuk menyetujui beasiswa
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Text(
                                          'Setujui',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Text('Alamat: ${beasiswa['alamat']}'),
                            SizedBox(height: 5.0),
                            // Menampilkan gambar jika tersedia, jika tidak tampilkan placeholder
                            isImageAvailable
                                ? Image.network(
                                    'http://127.0.0.1:8000/images/${beasiswa['foto_nilai_rapor']}',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.image_not_supported,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                            SizedBox(height: 5.0),
                            Text('Keterangan: ${beasiswa['keterangan']}'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
