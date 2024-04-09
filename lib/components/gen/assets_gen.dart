/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/search.svg
  String get search => 'assets/icon/search.svg';

  /// File path: assets/icons/menu_vector.svg
  SvgGenImage get menuVector =>
      const SvgGenImage('assets/icon/menu_vector.svg');

  /// File path: assets/icons/menu_vector_border.svg
  SvgGenImage get menuVectorBorder =>
      const SvgGenImage('assets/icon/menu_vector_border.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        menuVector,
        menuVectorBorder,
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  AssetGenImage get splash => const AssetGenImage('assets/images/splash.png');

  AssetGenImage get biaanh1 => const AssetGenImage('assets/images/biaanh1.png');

  AssetGenImage get biaanh2 => const AssetGenImage('assets/images/biaanh2.png');

  AssetGenImage get services1 =>
      const AssetGenImage('assets/images/services1.png');

  AssetGenImage get services2 =>
      const AssetGenImage('assets/images/services2.png');

  AssetGenImage get services3 =>
      const AssetGenImage('assets/images/services3.png');

  AssetGenImage get backgroundProfile =>
      const AssetGenImage('assets/images/backgroundProfile.png');

  AssetGenImage get avatar_default =>
      const AssetGenImage('assets/images/avatar_default.png');
  AssetGenImage get background_clean =>
      const AssetGenImage('assets/images/background_clean.png');

  AssetGenImage get icon_cleanhouse =>
      const AssetGenImage('assets/images/icon_cleanhouse.png');

  AssetGenImage get background_clean1 =>
      const AssetGenImage('assets/images/background_clean1.png');

  AssetGenImage get background_clean2 =>
      const AssetGenImage('assets/images/background_clean2.png');

  AssetGenImage get bath_services =>
      const AssetGenImage('assets/images/bath_services.png');

  AssetGenImage get onboardings =>
      const AssetGenImage('assets/images/onboarding_1.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        splash,
        biaanh1,
        biaanh2,
        services1,
        services2,
        services3,
        backgroundProfile,
        avatar_default,
        background_clean,
        icon_cleanhouse,
        background_clean1,
        background_clean2,
        bath_services,
      ];
}

class Assets {
  Assets._();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      // colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
