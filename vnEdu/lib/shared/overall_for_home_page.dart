

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/modal/overall.dart';
import 'package:vnedu/shared/overall_home_page_details.dart';

var data;
class OverallForHomePage extends StatelessWidget {
  OverallForHomePage({super.key, required this.overall});
  Overall? overall;

  String formatData(int?  s) {
    if(s == null) return '';
    if(s >= 1000) {
      double ans = s / 1000;
      return "${ans.toStringAsFixed(1).replaceAll('.', ',')}K";
    }else if(s >= 1000000) {
      double ans = s / 1000000;
      return "${ans.toStringAsFixed(1).replaceAll('.', ',')}M";
    }else if(s > 1000000000) {
      double ans = s / 1000000000;
      return "${ans.toStringAsFixed(1).replaceAll('.', ',')}T";
    }
    return "$s";
  }

  @override
  Widget build(BuildContext context) {
    final overall = this.overall;
    if(overall != null) {
      return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OHPDetail(icon: 'assets/images/balo.png', name: 'Giáo viên', value: formatData(overall.soTKGiaoVien)),
          OHPDetail(icon: 'assets/images/student.png', name: 'Học sinh', value: formatData(overall.soTKHocSinh)),
          OHPDetail(icon: 'assets/images/book.png', name: 'Học liệu', value: formatData(overall.soLuongHocLieu)),
          OHPDetail(icon: 'assets/images/champion.png', name: 'Cuộc thi', value: formatData(overall.soLuongCuocThi)),
          OHPDetail(icon: 'assets/images/access.png', name: 'Lượt truy cập', value: formatData(overall.soNguoiTruyCap)),
        ],
      ),
    );
    }else {
      return Container(width: MediaQuery.of(context).size.width, height: 10, color: Colors.white,);
    }
  }

}