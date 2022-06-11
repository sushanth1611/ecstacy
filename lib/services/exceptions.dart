class AppException implements Exception {
  final message;
  final prefix;

  AppException({
    required this.message,
    required this.prefix,
  });
}

class GoogleLoginError extends AppException {
  GoogleLoginError([message])
      : super(
          message: message,
          prefix: "There is an error occurred",
        );
}

// It happens when user doesn't select any email at selection
class EmailDNError extends AppException {
  EmailDNError([message])
      : super(
          message: message,
          prefix: "Account should be selected",
        );
}

// In future when we implement more login process we can get more errors