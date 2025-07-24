class AuthService {
  bool login(String username, String password) {
    // TODO: À remplacer par une vraie vérification avec base de données
    return username == 'admin' && password == 'password';
  }
}
