class PhoneValidator {
  const PhoneValidator();

  bool isValid(String phoneNumber) {
    // La regex ^\d+$ asegura que solo se permitan números enteros
    return RegExp(r"^\d+$").hasMatch(phoneNumber);
  }
}
