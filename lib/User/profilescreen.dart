import 'package:flutter/material.dart';
import 'package:pptsb/User/color.dart' as color;
import 'package:pptsb/User/home_page_user.dart';
import 'package:pptsb/login_form.dart';  // Pastikan jalur impor sesuai dengan struktur proyek Anda

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // Background Image
        Image.asset(
          'assets/back.jpg',
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
        // Container Gradient Overlay
        Container(
          height: 330,
          decoration: BoxDecoration(
            color: color.AppColor.merahMerona,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(200),
              bottomRight: Radius.circular(200),
            ),
          ),
        ),
        // Positioned Container at the bottom of the screen
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              color: color.AppColor.merahMerona,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(200),
                topRight: Radius.circular(200),
              ),
            ),
          ),
        ),
        // Scaffold for the main content
        Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePageUser()),
                    );
                  },
                  child: Icon(Icons.home),
                ),
                label: 'Home',
              ),
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
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'PROFILE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: height * 1,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double innerHeight = constraints.maxHeight;
                            double innerWidth = constraints.maxWidth;
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                  bottom: innerHeight * 0.2, // Adjusted position
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: innerHeight * 0.65,
                                    width: innerWidth,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: color.AppColor.merahTerang,
                                        width: 5,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Container(
                                      // Padding for the border
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: color.AppColor.merahTerang,
                                          width: 5,
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/man1.png',
                                          width: innerWidth * 0.45,
                                          height: innerWidth * 0.45,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Textfield and other information
                                Positioned(
                                  bottom: innerHeight * 0.19,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            'Username',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 20),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      initialValue: 'JohnDoe',
                                                      enabled: false,
                                                      decoration: InputDecoration(
                                                        labelText: 'Nama Lengkap',
                                                        labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              TextFormField(
                                                initialValue: 'johndoe@example.com',
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Email',
                                                  labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              TextFormField(
                                                initialValue: 'Jalan Asahan Km.4 No 108',
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Alamat',
                                                  labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              TextFormField(
                                                initialValue: '1234565432',
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  labelText: 'NIK',
                                                  labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              TextFormField(
                                                initialValue: '0987656789',
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Nomor Telepon',
                                                  labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              TextFormField(
                                                initialValue: 'Karyawan Swasta',
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Pekerjaan',
                                                  labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Container(
                                                height: 40,
                                                width: MediaQuery.of(context).size.width,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    // Action when logout button is pressed
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => LoginPage()),
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: color.AppColor.merahMerona,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Logout',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: color.AppColor.putihPucat,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              // Add more TextFormField for other fields if needed
                                            ],
                                          ),
                                        ),
                                        // Add more information here if needed
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
