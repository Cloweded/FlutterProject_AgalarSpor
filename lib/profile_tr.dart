import 'package:agalarspor/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'shopping_cart.dart';

class ProfilePageTR extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageTR> {
  final PageController _pageController = PageController();

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dil Seç'),
          content: Text('Dil seçmek emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: Text('Hayır'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Kabul Et'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => WelcomeScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.blue),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ShoppingPage()),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          return buildProfilePage(
              index % 2 == 0 ? 'Ömer Kasap' : 'Bahrican Arayıcı',
              index % 2 == 0
                  ? 'omer.fbkasap@gmail.com'
                  : 'bahricansoftware@gmail.com',
              index % 2 == 0 ? 'assets/profile.png' : 'assets/profile3.png',
              index % 2 == 0 ? 'İstanbul, Türkiye' : 'İstanbul, Türkiye',
              index % 2 == 0
                  ? 'Bilgisayar Programcılığı'
                  : 'Bilgisayar Programcılığı',
              index % 2 == 0 ? 'İstinye Üniversitesi' : 'İstinye Üniversitesi');
        },
        physics: AlwaysScrollableScrollPhysics(),
      ),
    );
  }

  Widget buildProfilePage(String name, String email, String imagePath,
      String location, String position, String education) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromARGB(0, 255, 255, 255),
            const Color.fromARGB(0, 255, 255, 255)
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40),
            CircleAvatar(radius: 100, backgroundImage: AssetImage(imagePath)),
            SizedBox(height: 24),
            Text(name,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 30, 157, 231),
                    letterSpacing: 1.2)),
            Text(email,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade800)),
            SizedBox(height: 40),
            Card(
              color: const Color.fromARGB(0, 255, 255, 255),
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.location_on, color: Colors.blue),
                        title: Text('Konum'),
                        subtitle: Text(location)),
                    Divider(),
                    ListTile(
                        leading:
                            Icon(Icons.business_center, color: Colors.blue),
                        title: Text('Pozisyon'),
                        subtitle: Text(position)),
                    Divider(),
                    ListTile(
                        leading: Icon(Icons.school, color: Colors.blue),
                        title: Text('Eğitim'),
                        subtitle: Text(education)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.exit_to_app),
              label: Text('Çıkış Yap'),
              onPressed: _showLogoutDialog,
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 9, 128, 226),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ],
        ),
      ),
    );
  }
}
