class NotAuthenticatedException implements Exception {}
class TweetNotFoundException implements Exception {}
class UserNotFoundException implements Exception {}
class UpdateUserFieldErrorException implements Exception {
  UpdateUserFieldErrorException(this.errors);
  Map<String, dynamic> errors;
}