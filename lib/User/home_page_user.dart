import 'package:flutter/material.dart';
import 'package:pptsb/User/Kepengurusan_PPTSB.dart';
import 'package:pptsb/User/custom_card.dart';
import 'package:pptsb/User/custom_image.dart';
import 'package:pptsb/User/Request.dart';
import 'package:pptsb/User/profilescreen.dart';
import 'package:pptsb/User/videoinfo.dart';
import 'package:pptsb/User/color.dart' as color;

class HomePageUser extends StatefulWidget {
  const HomePageUser({Key? key}) : super(key: key);

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  final List<Map<String, dynamic>> cardData = [
    {
      'title': 'Pusat',
      'infoA': 'Informasi lengkap pusat',
      'infoB': 'Melihat informasi',
      'imagePath': 'assets/pusat.jpg',
    },
    {
      'title': 'Regional',
      'infoA': 'Informasi lengkap regional untuk',
      'infoB': 'Melihat informasi regional',
      'imagePath': 'assets/regional.jpg',
    },
    {
      'title': 'Sektor',
      'infoA': 'Informasi lengkap sektor untuk',
      'infoB': 'Melihat informasi sektor',
      'imagePath': 'assets/sektor.jpg',
    },
    {
      'title': 'Cabang',
      'infoA': 'Informasi lengkap Cabang untuk',
      'infoB': 'Melihat informasi cabang',
      'imagePath': 'assets/cabang.jpg',
    },
  ];

  Set<Map<String, dynamic>> CustomImages = {
    {'gambarCustom': 'assets/man1.png', 'konteks': 'Ketua'},
    {'gambarCustom': 'assets/man2.png', 'konteks': 'Wakil Ketua'},
    {'gambarCustom': 'assets/old-man.png', 'konteks': 'Sekretaris'},
    {'gambarCustom': 'assets/woman2.png', 'konteks': 'Bendahara'},
  };
  String? _selectedMenu;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> customImagesList = CustomImages.toList();

    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined), label: 'Pencarian'),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilScreen()),
                );
              },
              child: Icon(Icons.account_circle),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/back.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage('assets/PPTSB.jpeg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "PPTSB",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Parsadaan Pomparan Toga Sinaga Dohot Boru',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert),
                          offset: Offset(0, 0),
                          onSelected: (String value) {
                            setState(() {
                              _selectedMenu = value;
                            });
                            if (value == 'Request') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RequestPages(),
                                ),
                              );
                            } else if (value == 'Logout') {
                              _showLogoutDialog(context);
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'Request',
                              child: Text('Request'),
                            ),
                            PopupMenuItem<String>(
                              value: 'Logout',
                              child: Text('Logout'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            20), // Mengatur sudut melengkung
                        color: color.AppColor.boxBerita,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(5, 10),
                            blurRadius: 10,
                            color: color.AppColor.merahMerona.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage('assets/business.png'),
                                fit: BoxFit.fill,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 40,
                                  offset: Offset(8, 10),
                                  color: color.AppColor.merahMerona
                                      .withOpacity(0.3),
                                ),
                                BoxShadow(
                                  blurRadius: 10,
                                  offset: Offset(-1, -5),
                                  color: color.AppColor.merahMerona
                                      .withOpacity(0.3),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Temukan Berita, Informasi, dan",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Pengumuman?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoInfo()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: color.AppColor.button,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  "Lihat Sekarang",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: color.AppColor
                                        .putihPucat, // Tambahkan properti color dengan nilai warna hitam
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    child: Container(
                      width: double.infinity,
                      height: 245,
                      decoration: BoxDecoration(
                        color: Color(0xFFC0210B),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Text(
                              "Data Kepengurusan PPTSB",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Wrap(
                                spacing: 15,
                                children: [
                                  for (var imageData in customImagesList)
                                    CustomImageWidget(
                                      key: UniqueKey(),
                                      gambarCustom: imageData['gambarCustom'],
                                      konteks: imageData['konteks'],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KepengurusanPPTSB()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Row(
                                children: [
                                  Text(
                                    "Lihat Detail",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_circle_right_outlined,
                                    size: 25,
                                    color: color.AppColor.putihPucat,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 5),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cardData.length > 4 ? 4 : cardData.length,
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> data = cardData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomCard(
                          key: UniqueKey(),
                          title: data['title'],
                          infoA: data['infoA'],
                          infoB: data['infoB'],
                          imagePath: data['imagePath'],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Apakah Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(context);
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
