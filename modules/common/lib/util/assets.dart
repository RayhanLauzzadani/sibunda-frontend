import 'dart:io';

import 'package:common/arch/domain/model/img_data.dart';
import 'package:common/arch/ui/widget/_basic_widget.dart';
import 'package:common/arch/ui/widget/img_widget.dart';
import 'package:common/config/_config.dart';
import 'package:core/util/_consoles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class SibImages {
  SibImages._();
  static Widget get(
    String fileName, {
    String? package,
    double? width,
    double? height,
    BoxFit? fit,
    bool showError = false,
  }) {
    final usedFit = fit ?? BoxFit.cover;
    final dir = getDir(fileName);
    if (package != null) {
      if (fileName.endsWith(".svg") || fileName.endsWith(".png")) {
        // Added condition for PNG
        return Image.asset(
          dir,
          width: width,
          height: height,
          fit: usedFit,
          package: package,
          errorBuilder: (
            ctx,
            error,
            stackTrace,
          ) {
            prind(
                "SibImages.get() image with file name '$fileName' doesn't exist in package '$package'. Trying to look in default package...");
            return get(
              fileName,
              width: width,
              height: height,
              fit: usedFit,
            );
          },
        );
      } else {
        return defaultEmptyWidget();
      }
    } else {
      if (fileName.endsWith(".svg")) {
        return SvgPicture.asset(
          dir,
          width: width,
          height: height,
          fit: usedFit,
          placeholderBuilder: (ctx) => !showError
              ? defaultImg()
              : defaultError(text: "Svg img Load Error"),
        );
      } else if (fileName.endsWith(".png")) {
        // Added condition for PNG
        return Image.asset(
          dir,
          width: width,
          height: height,
          fit: usedFit,
          errorBuilder: !showError ? defImgBuilder() : defImgErrorBuilder(),
        );
      } else {
        // return defaultError(text: "Unsupported image format");
        return defaultLoading();
      }
    }
  }

  static String getDir(String fileName) =>
      !fileName.contains("/") ? "assets/images/$fileName" : fileName;

  static Widget file(
    String fileName, {
    double? width,
    double? height,
    BoxFit? fit,
    bool showError = false,
  }) {
    final usedFit = fit ?? BoxFit.cover;
    final file = File(fileName);
    if (fileName.endsWith(".svg")) {
      return SvgPicture.file(
        file,
        width: width,
        height: height,
        fit: usedFit,
        placeholderBuilder: (ctx) => !showError
            ? defaultImg()
            : defaultError(text: "Svg img Load Error"),
      );
    } else if (fileName.endsWith(".png")) {
      // Added condition for PNG
      return Image.file(
        file,
        width: width,
        height: height,
        fit: usedFit,
        errorBuilder: !showError ? defImgBuilder() : defImgErrorBuilder(),
      );
    } else {
      return defaultError(text: "Unsupported image format");
    }
  }

  static Widget resolve(
    ImgData data, {
    BoxFit? fit,
    double? width,
    double? height,
  }) {
    final usedFit = fit ?? BoxFit.cover;
    switch (data.src) {
      case ImgSrc.network:
        return buildImgNetwork(
          data.link,
          fit: usedFit,
          width: width,
          height: height,
        );
      case ImgSrc.asset:
        return get(
          data.link,
          package: data.package,
          fit: usedFit,
          width: width,
          height: height,
        );
      case ImgSrc.file:
        return file(
          data.link,
          fit: usedFit,
          width: width,
          height: height,
        );
    }
  }
}

ImgData getDefaultAssetImg(String link) => ImgData(
      link: link,
      package: GlobalRoutes.common,
      src: ImgSrc.asset,
    );
