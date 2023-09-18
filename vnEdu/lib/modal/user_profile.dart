

class UserProfile {
  final dynamic ten;
  final dynamic ngaySinh;
  final dynamic gioiTinh;
  final dynamic donVi;
  final dynamic khoiHoc;
  final dynamic lopHoc;
  final dynamic tenDangNhap;
  final dynamic soDienThoai;
  final dynamic email;
  final dynamic diaChi;
  final dynamic avt;
  final dynamic imageId;
  final dynamic imageIdIdentify;
  final dynamic imageUrlIdentify;
  final dynamic needChangeIdentifyImage;
  final dynamic publicSensInfor;

  UserProfile({
    required this.ten,
    required this.ngaySinh,
    required this.gioiTinh,
    required this.donVi,
    required this.khoiHoc,
    required this.lopHoc,
    required this.tenDangNhap,
    required this.soDienThoai,
    required this.email,
    required this.diaChi,
    required this.avt,
    required this.imageId,
    required this.imageIdIdentify,
    required this.imageUrlIdentify,
    required this.needChangeIdentifyImage,
    required this.publicSensInfor
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        ten: json['ten'],
        ngaySinh: json['ngaySinh'],
        gioiTinh: json['gioiTinh'],
        donVi: json['donVi'],
        khoiHoc: json['khoiHoc'],
        lopHoc: json['lopHoc'],
        tenDangNhap: json['tenDangNhap'],
        soDienThoai: json['soDienThoai'],
        email: json['email'],
        diaChi: json['diaChi'],
        avt: json['avt'],
        imageId: json['imageId'],
        imageIdIdentify: json['imageIdIdentify'],
        imageUrlIdentify: json['imageUrlIdentify'],
        needChangeIdentifyImage: json['needChangeIdentifyImage'],
        publicSensInfor: json['publicSensInfor']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ten': ten,
      'ngaySinh': ngaySinh,
      'gioiTinh': gioiTinh,
      'donVi': donVi,
      'khoiHoc': khoiHoc,
      'lopHoc': lopHoc,
      'tenDangNhap': tenDangNhap,
      'soDienThoai': soDienThoai,
      'email': email,
      'diaChi': diaChi,
      'avt': avt,
      'imageId': imageId,
      'imageIdIdentify': imageIdIdentify,
      'imageUrlIdentify': imageUrlIdentify,
      'needChangeIdentifyImage': needChangeIdentifyImage,
      'publicSensInfor': publicSensInfor
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}