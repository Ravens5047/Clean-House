class OrderDetailsResponse {
  final String message;

  OrderDetailsResponse({
    required this.message,
  });

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponse(
      message: json['message'],
    );
  }
}
