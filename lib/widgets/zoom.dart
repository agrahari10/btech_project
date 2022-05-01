import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomImage extends StatefulWidget {
  NetworkImage image;
  ZoomImage({required this.image});

  @override
  State<ZoomImage> createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: PhotoView(
                minScale: PhotoViewComputedScale.contained,
                maxScale: 2.0,
                imageProvider: widget.image,
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  semanticLabel: 'close',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
