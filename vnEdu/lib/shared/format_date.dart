
import 'package:intl/intl.dart';

String formatDate_dd_mm_yyyy(String date) {
  DateFormat inputFormat = DateFormat("yyyy-MM-dd");
  DateFormat outputFormat = DateFormat("dd-MM-yyyy");
  DateTime dateTime = inputFormat.parse(date);
  return outputFormat.format(dateTime);
}

String formatDate_yyyy_mm_dd(String date) {
  DateFormat inputFormat = DateFormat('dd-MM-yyyy');
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  DateTime dateTime = inputFormat.parse(date);
  return outputFormat.format(dateTime);
}

String formatDateHH_MM_dd_MM_yyyy(String dateString) {
  DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateFormat outputFormat = DateFormat("HH:mm dd/MM/yyyy");
  DateTime dateTime = inputFormat.parse(dateString);
  return outputFormat.format(dateTime);
}

String getThuNgayThang(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  String weekDay = '';
  switch(dateTime.weekday) {
    case 1:
      weekDay == 'Thứ hai';
      break;
    case 2:
      weekDay = 'Thứ ba';
      break;
    case 3:
      weekDay = 'Thứ tư';
      break;
    case 4:
      weekDay = 'Thứ năm';
      break;
    case 5:
      weekDay = 'Thứ sáu';
      break;
    case 6:
      weekDay == 'Thứ bảy';
      break;
    case 7:
      weekDay == 'Chủ nhật';
      break;
  }

  return '$weekDay, Ngày ${dateTime.day}/${dateTime.month}/${dateTime.year}';
}