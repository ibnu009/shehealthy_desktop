import 'package:flutter/material.dart';

import '../../../core/theme/app_primary_theme.dart';
import '../dialog/dialog_choose_image.dart';

class ImagePlaceHolderStatic extends StatelessWidget {
  final double? width, height;
  const ImagePlaceHolderStatic({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
     child: SizedBox(
       height: height ?? 100,
       width: width ?? 100,
       child: Image.asset('assets/placeholder.jpg', fit: BoxFit.cover,),
     ),
    );
  }
}
