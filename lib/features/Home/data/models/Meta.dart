class Meta {
  final String? createdAt;
  final String? updatedAt;
  final String? barcode;
  final String? qrCode;

  Meta({
    this.createdAt,
    this.updatedAt,
    this.barcode,
    this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      barcode: json['barcode'] as String?,
      qrCode: json['qrCode'] as String?,
    );
  }
}