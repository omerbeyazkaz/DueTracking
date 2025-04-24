import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Giriş başarılı
    } on FirebaseAuthException catch (e) {
      return e.message; // Firebase hata mesajını döndür
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
