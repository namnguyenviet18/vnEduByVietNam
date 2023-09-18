
class IntroInformation {
  final dynamic logoImage;
  final dynamic logoText;
  final dynamic aboutUs;
  final dynamic address;
  final dynamic firstPhoneNumber;
  final dynamic secondPhoneNumber;
  final dynamic email;
  final dynamic facebook;
  final dynamic tenDonVi;
  final dynamic headerBannerText;


  IntroInformation({this.logoImage, this.logoText, this.aboutUs, this.address,
      this.firstPhoneNumber, this.secondPhoneNumber, this.email, this.facebook, this.tenDonVi,
      this.headerBannerText});

  factory IntroInformation.fromJson(Map<String, dynamic> json) =>
      IntroInformation(
        logoImage: json['logo_image'],
        logoText: json['logo_text'],
        aboutUs: json['about_us'],
        address: json['dia_chi'],
        firstPhoneNumber: json['so_dien_thoai_thu_nhat'],
        secondPhoneNumber: json['so_dien_thoai_thu_hai'],
        email: json['email'],
        facebook: json['facebook'],
        tenDonVi: json['current_don_vi']['ten_day_du'],
        headerBannerText: json['header_banner_text']
      );
}