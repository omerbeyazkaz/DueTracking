import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/methods.dart';
import 'announcement_page.dart';
import 'requests_page.dart';

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
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!userDoc.exists) return;

      final siteId = userDoc.data()?['siteID'];
      final anns = await Methods.getAnnouncements(siteId);
      final reqs = await Methods.getRequests(uid);

      setState(() {
        _announcements = anns;
        _requests = reqs;
        _loading = false;
      });
    } catch (e) {
      print("Hata: $e");
    }
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
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.4, // Dynamic width
                          margin: EdgeInsets.only(right: 16),
                          child: _buildRequestCard(
                            item['title'] ?? '',
                            item['description'] ?? '',
                          ),
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
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: onTap,
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
        children: [
          Expanded(
            child: Column(
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
                    Icon(Icons.calendar_today,
                        color: Colors.white70, size: 16),
                    SizedBox(width: 4),
                    Text("Son Ödeme Tarihi: 30.03.2022",
                        style:
                            TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ],
            ),
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
      margin: EdgeInsets.symmetric(vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(Icons.campaign, color: Colors.blueAccent),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCard(String title, String description) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 6),
          Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}