class AuthenticationRepository {
  Future<void> signIn(String email, String password) async {
    const fakeEmail = 't@gmail.com';
    const fakePassword = 'pass';
    print('call signIn');
    print('email: $email, password: $password');
    if (email == fakeEmail && password == fakePassword) {
      return Future.value();
    } else {
      print('Invalid email or password');
      throw Exception('Invalid email or password');
    }
    ;
  }
}
