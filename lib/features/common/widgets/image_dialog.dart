import 'package:cached_network_image/cached_network_image.dart';
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
        imageProvider: CachedNetworkImageProvider(imageUrl),
        tightMode: true,
        minScale: PhotoViewComputedScale.contained * 1,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    ),
    barrierColor: Colors.black87,
  );
}