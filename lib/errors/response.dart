class InvalidUsernameOrPasswordError extends Error {
  @override
  String toString() => 'Incorrect username or password';
}
