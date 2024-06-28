class LogInWithPhoneException implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithPhoneException([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithPhoneException.fromCode(String code) {
    switch (code) {
      case 'invalid-credential':
        return const LogInWithPhoneException(
          'The supplied credentials are incorrect or has expired.',
        );
      case 'invalid-phone':
        return const LogInWithPhoneException(
          'Email is not valid or badly formatted.',
        );
      case 'phone-not-found':
        return const LogInWithPhoneException(
          'Email is not found, please create an account.',
        );
      default:
        return const LogInWithPhoneException();
    }
  }

  /// The associated error message.
  final String message;
}
