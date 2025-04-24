import 'package:flutter/material.dart';
import '../services/methods.dart';

class RequestsPage extends StatefulWidget {
  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  List<Map<String, dynamic>> _requests = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    final userId = 'user_abc'; // Giriş yapan kullanıcının userId’si
    final reqs = await Methods.getRequests(userId);

    setState(() {
      _requests = reqs;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tüm Taleplerim")),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _requests.length,
              itemBuilder: (context, index) {
                final item = _requests[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Icon(Icons.assignment, color: Colors.green),
                    title: Text(item['title'] ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(item['description'] ?? ''),
                  ),
                );
              },
            ),
    );
  }
}
