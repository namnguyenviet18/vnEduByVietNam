

class Overall {
  final int? soNguoiTruyCap;
  final int? soTKGiaoVien;
  final int? soTKHocSinh;
  final int? soLuongHocLieu;
  final int? soLuongCuocThi;

  Overall({this.soNguoiTruyCap, this.soTKGiaoVien, this.soTKHocSinh,
      this.soLuongHocLieu, this.soLuongCuocThi});

  factory Overall.fromJson(Map<String, dynamic> json) =>
      Overall(
        soNguoiTruyCap: json['so_nguoi_truy_cap'],
        soTKGiaoVien: json['so_tai_khoan_giao_vien'],
        soTKHocSinh: json['so_tai_khoan_hoc_sinh'],
        soLuongHocLieu: json['so_luong_hoc_lieu'],
        soLuongCuocThi: json['so_luong_cuoc_thi']
      );
}