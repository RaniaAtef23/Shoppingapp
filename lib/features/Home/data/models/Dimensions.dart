class Dimensions {
  final num? width;
  final num? height;
  final num? depth;

  Dimensions({
    this.width,
    this.height,
    this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: json['width'] as num?,
      height: json['height'] as num?,
      depth: json['depth'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (width != null) map['width'] = width;
    if (height != null) map['height'] = height;
    if (depth != null) map['depth'] = depth;
    return map;
  }

  Dimensions copyWith({
    num? width,
    num? height,
    num? depth,
  }) {
    return Dimensions(
      width: width ?? this.width,
      height: height ?? this.height,
      depth: depth ?? this.depth,
    );
  }
}