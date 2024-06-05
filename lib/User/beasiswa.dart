import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'edit_beasiswa.dart';
import 'tambah_beasiswa.dart';

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
                                GestureDetector(
                                  onTap: () async {
                                    String? pop = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditBeasiswaPage(
                                          beasiswa: beasiswa,
                                        ),
                                      ),
                                    );

                                    if (pop == "data-updated") {
                                      _refreshData();
                                    }
                                  },
                                  child: Icon(Icons.edit, color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Text('Alamat: ${beasiswa['alamat']}'),
                            SizedBox(height: 5.0),
                            // Menampilkan gambar menggunakan URL
                            Image.network(
                              'http://127.0.0.1:8000/images/${beasiswa['foto_nilai_rapor']}',
                              width: 100, // Sesuaikan dengan kebutuhan
                              height: 100, // Sesuaikan dengan kebutuhan
                              fit: BoxFit.cover,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? pop = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahBeasiswaPage(),
            ),
          );

          if (pop == "data-added") {
            _refreshData();
          }
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
      // Tambahkan bottomNavigationBar jika diperlukan
    );
  }
}
