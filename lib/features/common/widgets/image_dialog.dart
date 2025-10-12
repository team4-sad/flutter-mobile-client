import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void showNetworkImageDialog(BuildContext context, String imageUrl){
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: PhotoView(
        backgroundDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        tightMode: true,
        imageProvider: NetworkImage(imageUrl),
        minScale: PhotoViewComputedScale.contained * 1,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    ),
    barrierColor: Colors.black87,
  );
}