String? appValidator({
  required String value,
  bool isRequired = true,
  bool isEmail = false,
  bool isPassword = false,
  int minLength = 0,
  int maxLength = 100,
}) {
  // Check if the field is required and is empty
  if (isRequired && value.isEmpty) {
    return 'This field is required';
  }

  // Check for email format
  if (isEmail) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
  }

  // Check for password strength
  if (isPassword) {
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
  }

  // Check for minimum length
  if (value.length < minLength) {
    return 'Minimum length is $minLength characters';
  }

  // Check for maximum length
  if (value.length > maxLength) {
    return 'Maximum length is $maxLength characters';
  }

  return null; // No validation errors
}
