

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/shared/custom_button.dart';

class StudyCornerDetails extends StatelessWidget {
  const StudyCornerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonStudyCorner(
            context,
            const Icon(Icons.developer_board, color: Colors.blueGrey, size: 23,),
            'Dashboard',
                () { }
        ),
        ButtonStudyCorner(
            context,
            const Icon(Icons.note_alt_rounded, color: Colors.blueGrey, size: 23,),
            'Lớp học',
                () { }
        ),
        ButtonStudyCorner(
            context,
            const Icon(Icons.note_alt_rounded, color: Colors.blueGrey, size: 23,),
            'Khóa học',
                () { }
        ),
        ButtonStudyCorner(
            context,
            const Icon(Icons.developer_board, color: Colors.blueGrey, size: 23,),
            'Kỳ thi',
                () { }
        ),
        ButtonStudyCorner(
            context,
            const Icon(Icons.developer_board, color: Colors.blueGrey, size: 23,),
            'Khảo sát',
                () { }
        ),
        ButtonStudyCorner(
            context,
            const Icon(Icons.developer_board, color: Colors.blueGrey, size: 23,),
            'Gói combo',
                () { }
        ),
        ButtonStudyCorner(
            context,
            const Icon(Icons.developer_board, color: Colors.blueGrey, size: 23,),
            'Tự học',
                () { }
        ),
        ButtonStudyCorner(
            context,
            const Icon(Icons.developer_board, color: Colors.blueGrey, size: 23,),
            'Thống kê thành tích',
                () { }
        ),
        ButtonStudyCorner(
            context,
            const Icon(Icons.developer_board, color: Colors.blueGrey, size: 23,),
            'Bộ sưu tập',
                () { }
        )
      ],
    );
  }

}