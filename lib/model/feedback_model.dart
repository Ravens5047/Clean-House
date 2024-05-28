class FeedbackRequestModel {
  int? feedback_id;
  int? user_id;
  String? content;
  String? full_name;
  String? email;
  String? created_at;
  int? created_by_id;
  String? updated_at;
  int? updated_by_id;
  int? service_id;
  double? rating;

  FeedbackRequestModel({
    this.feedback_id,
    this.user_id,
    this.full_name,
    this.email,
    this.created_at,
    this.created_by_id,
    this.updated_at,
    this.updated_by_id,
    this.service_id,
    this.rating,
    this.content,
  });

  factory FeedbackRequestModel.fromJson(Map<String, dynamic> json) {
    return FeedbackRequestModel(
      feedback_id: json['feedback_id'] as int?,
      user_id: json['user_id'] as int?,
      full_name: json['full_name'] as String?,
      email: json['email'] as String?,
      created_at: json['created_at'] as String?,
      created_by_id: json['created_by_id'] as int?,
      updated_at: json['updated_at'] as String?,
      updated_by_id: json['updated_by_id'] as int?,
      service_id: json['service_id'] as int?,
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString())
          : null,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'feedback_id': feedback_id,
      'user_id': user_id,
      'full_name': full_name,
      'email': email,
      'created_at': created_at,
      'created_by_id': created_by_id,
      'updated_at': updated_at,
      'updated_by_id': updated_by_id,
      'service_id': service_id,
      'rating': rating,
      'content': content,
    };
  }
}
