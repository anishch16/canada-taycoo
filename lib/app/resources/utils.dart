import 'dart:io';

import 'package:barcode/barcode.dart';

String buildBarcodeSvg(Barcode bc, String data) {
  return bc.toSvg(
    data,
  );
}
