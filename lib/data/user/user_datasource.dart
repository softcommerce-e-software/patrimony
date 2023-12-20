abstract class UserDataSource {
  Future<bool> login(String provider);
  Future<bool> logout();
  Future<bool> isLoggedUser();
  Future<bool> isAdmin();
}