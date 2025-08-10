import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<GoogleSignInAccount?> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      return account;
    } catch (error) {
      throw Exception('Google Sign-In failed: $error');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
