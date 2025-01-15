import 'package:flutter/material.dart';
import 'profile.dart'; // ProfilePage dosyasını içe aktarın
import 'payment.dart'; // PaymentPage dosyasını içe aktarın

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Alt menüdeki seçili sayfa

  final List<Widget> _pages = [
    HomePageContent(), // Ana Sayfa widget'ı içeren bir içerik widget'ı
    PaymentPage(), // Ödeme Sayfası
    ProfilePage(), // Profil Sayfası
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.black),
        actions: [
          Icon(Icons.settings, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: _pages[_currentIndex], // Seçilen sekmeye göre sayfa gösterilir
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Seçili sekmeyi güncelle
          });
        },
        selectedItemColor: Color(0xFF636AE8),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Ödeme"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hoş Geldiniz 👋\nKullanıcı Adı",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            _buildCurrentBalanceCard(),
            SizedBox(height: 20),
            _buildSectionHeader(
              context,
              title: "Duyurular",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnnouncementsPage(),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            _buildAnnouncementList(),
            SizedBox(height: 20),
            _buildSectionHeader(
              context,
              title: "Taleplerim",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestsPage(),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            _buildRequestCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "Hepsini Gör",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentBalanceCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF636AE8),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Güncel Tutar",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 4),
              Text(
                "850 TL",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.white70, size: 16),
                  SizedBox(width: 4),
                  Text(
                    "Son Ödeme Tarihi: 30.03.2022",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "ÖDENDİ",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementList() {
    return Column(
      children: [
        _buildAnnouncementCard("Asansör bakımı", "27.12.2024"),
        _buildAnnouncementCard("Çelik kapı bakımı", "17.12.2024"),
        _buildAnnouncementCard("Yönetici seçimleri", "10.01.2025"),
      ],
    );
  }

  Widget _buildAnnouncementCard(String title, String date) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(Icons.info_outline, color: Colors.blue),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(date),
      ),
    );
  }

  Widget _buildRequestCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildRequestCard("Su Arızası", "Talep 1"),
          _buildRequestCard("Elektrik Kesintisi", "Talep 2"),
          _buildRequestCard("Boya Tadilatı", "Talep 3"),
        ],
      ),
    );
  }

  Widget _buildRequestCard(String title, String description) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }
}

class AnnouncementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Duyurular"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text("Asansör bakımı"),
            subtitle: Text("27.12.2024"),
          ),
          ListTile(
            title: Text("Çelik kapı bakımı"),
            subtitle: Text("17.12.2024"),
          ),
          ListTile(
            title: Text("Yönetici seçimleri"),
            subtitle: Text("10.01.2025"),
          ),
        ],
      ),
    );
  }
}

class RequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Taleplerim"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text("Su Arızası"),
            subtitle: Text("Talep 1"),
          ),
          ListTile(
            title: Text("Elektrik Kesintisi"),
            subtitle: Text("Talep 2"),
          ),
          ListTile(
            title: Text("Boya Tadilatı"),
            subtitle: Text("Talep 3"),
          ),
        ],
      ),
    );
  }
}
