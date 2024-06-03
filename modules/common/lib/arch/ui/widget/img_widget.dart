import 'package:core/util/_consoles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'default_widget.dart';

Widget buildImgNetwork(
  String src, {
  Widget Function(
    BuildContext context,
    Widget? child,
    ImageChunkEvent? loadingProgress,
  )?
      loadingBuilder,
  Widget Function(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  )?
      errorBuilder,
  BoxFit? fit,
  double? width,
  double? height,
}) {
  final usedFit = fit ?? BoxFit.cover;
  prind(
      "buildImgNetwork src= $src src.endsWith(\".svg\")= ${src.endsWith(".svg")}");
  if (src.endsWith(".svg")) {
    return SvgPicture.network(
      src,
      fit: usedFit,
      width: width,
      height: height,
      placeholderBuilder: (ctx) =>
          loadingBuilder?.call(ctx, null, null) ??
          defaultLoading(showText: false),
    );
  } else if (src.endsWith(".png")) {
    return Image.network(
      'https://$src',
      loadingBuilder: loadingBuilder ?? defImgLoadingBuilder(),
      errorBuilder: errorBuilder ?? defImgErrorBuilder(),
      fit: usedFit,
      width: width,
      height: height,
    );
  } else {
    return defaultError(text: "image format not supported");
  }
}

Widget Function(
  BuildContext context,
  Widget child,
  ImageChunkEvent? loadingProgress,
) defImgLoadingBuilder() => (context, child, loadingProgress) =>
    loadingProgress == null ? child : defaultLoading(showText: false);

Widget Function(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
) defImgBuilder() => (context, error, stackTrace) => defaultImg();

Widget Function(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
) defImgErrorBuilder() => (
      context,
      error,
      stackTrace,
    ) =>
        defaultError(text: "Img Load Error");
