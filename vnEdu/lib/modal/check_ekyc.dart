

class CheckEkyc {
  final dynamic image_id_identify;
  final dynamic image_url_identify;
  final dynamic hash_minio;
  final dynamic need_change_identify_image;
  final dynamic record_user_ext_id;

  CheckEkyc({
      required this.image_id_identify,
      required this.image_url_identify,
      required this.hash_minio,
      required this.need_change_identify_image,
      required this.record_user_ext_id
  });


  factory CheckEkyc.fromJson(Map<String, dynamic> json) {
    return CheckEkyc(
      image_id_identify: json['image_id_identify'],
      image_url_identify: json['image_url_identify'],
      hash_minio: json['hash_minio'],
      need_change_identify_image: json['need_change_identify_image'],
      record_user_ext_id: json['record_user_ext_id'],
    );
  }
}

