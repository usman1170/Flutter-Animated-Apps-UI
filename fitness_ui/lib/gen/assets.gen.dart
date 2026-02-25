import 'package:flutter/widgets.dart';

class Assets {
  Assets._();

  static const ImagesGen images = ImagesGen();
}

class ImagesGen {
  const ImagesGen();

  LockerGen get locker => const LockerGen();
}

class LockerGen {
  const LockerGen();

  AssetGenImage get blackJacket =>
      const AssetGenImage('assets/images/locker/black_jacket.png');
  AssetGenImage get whiteTshirt =>
      const AssetGenImage('assets/images/locker/white_tshirt.png');
  AssetGenImage get blackTrouser =>
      const AssetGenImage('assets/images/locker/black_trouser.png');
  AssetGenImage get blueShirt =>
      const AssetGenImage('assets/images/locker/blue_shirt.png');
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  String get path => _assetName;

  Image image({
    Key? key,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      fit: fit,
      alignment: alignment,
      filterQuality: filterQuality,
    );
  }
}
