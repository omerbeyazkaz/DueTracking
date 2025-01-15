import 'package:flutter/material.dart';
import 'user_info_page.dart'; // Kullanıcı Bilgileri Sayfasını içe aktarın

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6FF), // Arka plan rengi
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Profil",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profil Fotoğrafı ve Kullanıcı Bilgileri
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/profile_pic.png'), // Profil fotoğrafı
                          backgroundColor: Colors.grey[200],
                        ),
                        IconButton(
                          icon: Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: () {
                            // Fotoğraf düzenleme işlemi
                          },
                          iconSize: 20,
                          color: Colors.black,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Memduh Öztürk",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "24472727",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Menü Seçenekleri
              _buildMenuOption(
                context,
                icon: Icons.person_outline,
                title: "Kullanıcı Bilgileri",
                onTap: () {
                  // Kullanıcı Bilgileri Sayfasına Git
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserInfoPage()),
                  );
                },
              ),
              _buildMenuOption(
                context,
                icon: Icons.notifications_outlined,
                title: "Bildirim ve İzinler",
                onTap: () {
                  // Bildirim ve İzinler Sayfasına Git
                },
              ),
              _buildMenuOption(
                context,
                icon: Icons.security,
                title: "Gizlilik ve Güvenlik",
                onTap: () {
                  // Gizlilik ve Güvenlik Sayfasına Git
                },
              ),
              _buildMenuOption(
                context,
                icon: Icons.support_agent_outlined,
                title: "Uygulama Ayarları ve Destek",
                onTap: () {
                  // Destek Sayfasına Git
                },
              ),
              SizedBox(height: 24),

              // Çıkış Butonu
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Çıkış Yap İşlemi
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Çıkış",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap,
    );
  }
}
