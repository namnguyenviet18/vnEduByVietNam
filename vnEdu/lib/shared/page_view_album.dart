

import 'package:flutter/cupertino.dart';

class PageViewAlbum extends StatelessWidget {
  const PageViewAlbum({super.key, required this.imageUrl1, required this.imageUrl2});
  final String? imageUrl1;
  final String? imageUrl2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 100,
            child: imageUrl1 == null ? null :
            Image.network(
              imageUrl1!,
              fit: BoxFit.cover,

            ),
          ),
          const SizedBox(width: 5,),
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 100,
            child: imageUrl2 == null ? null :
            Image.network(
              imageUrl2!,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }


}