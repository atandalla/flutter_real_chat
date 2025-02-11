class UnknownLoginException implements Exception {}

class InvalidEmailException implements Exception {
  @override
  String toString() => 'The email is invalid';
}

class InvalidPasswordConfirmationException implements Exception {
  @override
  String toString() => 'The password confirmation is invalid';
}

class InvalidPhoneConfirmationException implements Exception {
  @override
  String toString() => 'The phone confirmation is invalid';
}
