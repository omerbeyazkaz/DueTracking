import 'package:cloud_firestore/cloud_firestore.dart';


class Methods {
  // Duyuruları çekmek için metod
  static Future<List<Map<String, dynamic>>> getAnnouncements(String siteId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('announcements') // Koleksiyon adı
          .where('siteId', isEqualTo: siteId) // siteId'ye göre filtreleme
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Duyurular çekilirken bir hata oluştu: $e");
      return [];
    }
  }

  // Talepleri çekmek için metod
  static Future<List<Map<String, dynamic>>> getRequests(String userId) async {
    try {
      // Firestore'dan kullanıcının taleplerini çekiyoruz
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('requests') // Talepler koleksiyonu
          .where('userId', isEqualTo: userId) // Kullanıcıya göre filtreleme
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Talepler çekilirken bir hata oluştu: $e");
      return [];
    }
  }

  // Kullanıcı taleplerini (şikayetler, öneriler vs.) kaydetmek için metod
  static Future<void> sendFeedback({
    required String userId,
    required String title,
    required String description,
    required String type,
    required String siteId,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('feedbacks').add({
        'userId': userId,
        'title': title,
        'description': description,
        'type': type,
        'siteId': siteId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Geri bildirim başarıyla kaydedildi.");
    } catch (e) {
      print("Geri bildirim kaydedilirken hata oluştu: $e");
    }
  }

  // Kullanıcının ödeme geçmişini almak için metod
  static Future<List<Map<String, dynamic>>> getUserPayments(String userId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('payments')
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Ödemeler çekilirken bir hata oluştu: $e");
      return [];
    }
  }

  // Kullanıcının aidatlarını almak için metod
  static Future<List<Map<String, dynamic>>> getDues(String siteId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('dues')
          .where('siteId', isEqualTo: siteId)
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Aidat verileri çekilirken bir hata oluştu: $e");
      return [];
    }
  }

 
}

