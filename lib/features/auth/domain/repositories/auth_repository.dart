abstract class AuthRepository {
  Stream<bool> get authStateChanges;
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}
