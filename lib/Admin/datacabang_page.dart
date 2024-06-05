import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tambah_cabang_page.dart';
import 'edit_cabang_page.dart';

class DataCabangPage extends StatefulWidget {
  const DataCabangPage({super.key});

  @override
  State<DataCabangPage> createState() => _DataCabangPageState();
}

class _DataCabangPageState extends State<DataCabangPage> {
  Future<List<dynamic>> getData() async {
    final response =
        await http.get(Uri.parse("http://127.0.0.1:8000/api/cabang"));
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Cabang',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
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
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final cabang = list[index];
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    elevation: 5.0, // Menambahkan bayangan pada Card
                    shadowColor: Colors.black54, // Menambahkan warna bayangan
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () async {
                                String pop = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditCabangPage(cabang: cabang)),
                                );

                                if (pop == "data-updated") {
                                  setState(() {
                                    getData();
                                  });
                                }
                              },
                              child: Icon(Icons.edit),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Nama Cabang: ${cabang['Nama_cabang']}',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.0),
                          Text('Kode Cabang: ${cabang['Kode_cabang']}'),
                          SizedBox(height: 5.0),
                          Text('Alamat Cabang: ${cabang['Alamat_cabang']}'),
                          SizedBox(height: 5.0),
                          Text(
                              'Nama Kepala Cabang: ${cabang['Nama_kepala_cabang']}'),
                          SizedBox(height: 10.0),
                          Text('Tanggal Berdiri: ${cabang['Tanggal_berdiri']}'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahCabangPage()),
          );
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
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
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
