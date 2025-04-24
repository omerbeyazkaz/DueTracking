import 'package:flutter/material.dart';
import '../services/methods.dart'; // Firebase metotları için
import 'announcement_page.dart'; // Tüm duyurular
import 'requests_page.dart'; // Tüm talepler

class HomePageContent extends StatefulWidget {
  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  List<Map<String, dynamic>> _announcements = [];
  List<Map<String, dynamic>> _requests = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final siteId = 'site_123'; // Giriş yapan kullanıcının siteId’si
    final userId = 'user_abc'; // Giriş yapan kullanıcının userId’si

    final anns = await Methods.getAnnouncements(siteId);
    final reqs = await Methods.getRequests(userId);

    setState(() {
      _announcements = anns;
      _requests = reqs;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : Padding(
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
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AnnouncementsPage()),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: _announcements.map((item) {
                      return _buildAnnouncementCard(
                        item['title'] ?? '',
                        item['date'] ?? '',
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  _buildSectionHeader(
                    context,
                    title: "Taleplerim",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RequestsPage()),
                    ),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _requests.map((item) {
                        return _buildRequestCard(
                          item['title'] ?? '',
                          item['description'] ?? '',
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildSectionHeader(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onTap,
          child: Text("Hepsini Gör",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
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
              Text("Güncel Tutar", style: TextStyle(color: Colors.white)),
              SizedBox(height: 4),
              Text("850 TL",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.white70, size: 16),
                  SizedBox(width: 4),
                  Text("Son Ödeme Tarihi: 30.03.2022",
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
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
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
        ],
      ),
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
