class Reviews {
  final num? rating;
  final String? comment;
  final String? date;
  final String? reviewerName;
  final String? reviewerEmail;

  Reviews({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      rating: json['rating'] as num?,
      comment: json['comment'] as String?,
      date: json['date'] as String?,
      reviewerName: json['reviewerName'] as String?,
      reviewerEmail: json['reviewerEmail'] as String?,
    );
  }
}