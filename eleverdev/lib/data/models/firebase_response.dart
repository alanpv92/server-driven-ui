class FirebaseResponse<T> {
  final bool status;
  final T? data;
  final String? errorMessage;
  FirebaseResponse({required this.status, this.data, this.errorMessage});
}
