import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance;

  Future<User?> register(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    await cred.user?.sendEmailVerification();
    return cred.user;
  }

  Future<User?> login(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    await cred.user?.reload();
    if (!(_auth.currentUser?.emailVerified ?? false)) {
      await _auth.signOut();
      throw FirebaseAuthException(code: 'email-not-verified');
    }
    return _auth.currentUser;
  }

  Future<void> saveProfile({
    required String uid,
    required String displayName,
    String? designation,
    String? about,
  }) async {
    final email = _auth.currentUser!.email ?? '';
    await Future.wait([
      _auth.currentUser!.updateDisplayName(displayName),
      _db.ref('users/$uid').update({
        'uid': uid,
        'name': displayName,
        'email': email,
        'designation': designation ?? '',
        'about': about ?? '',
      }),
    ]);
  }

  Future<void> resetPassword(String email) =>
      _auth.sendPasswordResetEmail(email: email.trim());

  Future<void> logout() => _auth.signOut();

  static String message(FirebaseAuthException e) => switch (e.code) {
        'email-already-in-use' => 'An account with this email already exists.',
        'invalid-email' => 'Please enter a valid email address.',
        'weak-password' => 'Password must be at least 6 characters.',
        'invalid-credential' || 'wrong-password' || 'user-not-found' =>
          'Incorrect email or password.',
        'email-not-verified' =>
          'Please verify your email before signing in. Check your inbox.',
        'too-many-requests' =>
          'Too many attempts. Please try again later.',
        _ => e.message ?? 'Something went wrong. Please try again.',
      };
}
