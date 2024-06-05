import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tambah_sektor_page.dart';
import 'edit_sektor_page.dart';

class DataSektorPage extends StatefulWidget {
  const DataSektorPage({super.key});

  @override
  State<DataSektorPage> createState() => _DataSektorPageState();
}

class _DataSektorPageState extends State<DataSektorPage> {
  Future<List<dynamic>> getData() async {
    final response =
        await http.get(Uri.parse("http://127.0.0.1:8000/api/sektor"));
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
          'Data Sektor',
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
                  final sektor = list[index];
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
                                          EditSektorPage(sektor: sektor)),
                                );

                                if (pop == "data-updated") {
                                  setState(() {
                                    getData();
                                    print("test");
                                  });
                                }
                              },
                              child: Icon(Icons.edit),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Nama Sektor: ${sektor['Nama_sektor']}',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.0),
                          Text('Kode Sektor: ${sektor['Kode_sektor']}'),
                          SizedBox(height: 5.0),
                          Text('Alamat Sektor: ${sektor['Alamat_sektor']}'),
                          SizedBox(height: 5.0),
                          Text(
                              'Nama Kepala Sektor: ${sektor['Nama_kepala_sektor']}'),
                          SizedBox(height: 10.0),
                          Text('Tanggal Berdiri: ${sektor['Tanggal_berdiri']}'),
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
            MaterialPageRoute(builder: (context) => TambahSektorPage()),
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
