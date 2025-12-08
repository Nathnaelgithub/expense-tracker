class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    final regex = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$");
    if (!regex.hasMatch(value)) return "Invalid email format";
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return "Password required";
    if (value.length < 6) return "Minimum 6 characters";
    return null;
  }

  static String? nonEmpty(String? value) {
    if (value == null || value.trim().isEmpty) return "Field can't be empty";
    return null;
  }
}
