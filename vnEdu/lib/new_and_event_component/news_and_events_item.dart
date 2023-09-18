

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/controller/appbar_provider.dart';
import 'package:vnedu/modal/news_and_events.dart';
import 'package:provider/provider.dart';
import 'package:vnedu/new_and_event_component/image_description.dart';
import 'package:vnedu/new_and_event_component/preview.dart';
import 'package:provider/provider.dart';
import 'package:vnedu/screens/new_detail_screen.dart';

class NewAndEventItem extends StatefulWidget {
  const NewAndEventItem({super.key, required this.isLogged, required this.newsAndEvents});
  final bool isLogged;
  final NewsAndEvents? newsAndEvents;

  @override
  State<NewAndEventItem> createState() => _NewAndEventItemState();
}

class _NewAndEventItemState extends State<NewAndEventItem> {

  bool isHideTitle = false;

  @override
  Widget build(BuildContext context) {
    final appbarProvider = Provider.of<AppBarNotifier>(context, listen: false);
    return GestureDetector(
      onTap: () {
        setState(() {
          isHideTitle = !isHideTitle;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: Stack(
          children:isHideTitle ? [
            ImageDescription(isHideTitle: isHideTitle, newsAndEvents: widget.newsAndEvents,),
            PreviewNewsAndEvent(
                newsAndEvents: widget.newsAndEvents,
                showDetails: () {
                  appbarProvider.getDataForDetailNewScreen(widget.newsAndEvents?.id).then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        NewDetailScreen(
                          isLogged: widget.isLogged, detailNew: appbarProvider.detailNew,
                          othersNewAndEvent: appbarProvider.othersNewAndEvent,
                        )));
                  });
                }
            )
          ] : [
            PreviewNewsAndEvent(
                newsAndEvents: widget.newsAndEvents,
                showDetails: () {
                  appbarProvider.getDataForDetailNewScreen(widget.newsAndEvents?.id).then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        NewDetailScreen(
                          isLogged: widget.isLogged, detailNew: appbarProvider.detailNew,
                          othersNewAndEvent: appbarProvider.othersNewAndEvent,
                        )));
                  });
                }
            ),
            ImageDescription(isHideTitle: isHideTitle, newsAndEvents: widget.newsAndEvents,),
          ],
        ),
      ),
    );
  }

}