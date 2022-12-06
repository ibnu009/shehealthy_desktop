import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:she_healthy_desktop/core/theme/app_primary_theme.dart';

class LoadingWidget extends StatelessWidget {
  final double? height, width;
  final BoxFit? fit;
  final String? loadingAssets;
  const LoadingWidget({Key? key, this.height, this.width, this.fit, this.loadingAssets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              loadingAssets ?? 'assets/loading_pembayaran.json',
              height: height ?? 160,
              width: width ?? 160,
              fit: fit,
            ),
             Text('Menganalisa gambar...', style: AppTheme.subTitle,)
          ],
        ),
      ),
    );
  }
}
