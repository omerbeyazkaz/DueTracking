import 'package:flutter/material.dart';
import '../services/methods.dart';

class AnnouncementsPage extends StatefulWidget {
  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  List<Map<String, dynamic>> _announcements = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchAnnouncements();
  }

  Future<void> fetchAnnouncements() async {
    final siteId = 'site_123'; // Giriş yapan kullanıcının siteId’si
    final anns = await Methods.getAnnouncements(siteId);

    setState(() {
      _announcements = anns;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tüm Duyurular")),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _announcements.length,
              itemBuilder: (context, index) {
                final item = _announcements[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.campaign, color: Colors.orange),
                    title: Text(item['title'] ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(item['date'] ?? ''),
                  ),
                );
              },
            ),
    );
  }
}
