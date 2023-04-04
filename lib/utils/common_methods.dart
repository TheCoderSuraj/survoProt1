import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';

import 'constants.dart';

void showMyToast(
  String message, {
  bool isError = false,
}) {
  showToast(
    message,
    position: ToastPosition.bottom,
    textStyle: kDefaultTextStyle.copyWith(
      color: kWhiteColor,
    ),
    backgroundColor: isError ? Colors.red[500] : Colors.black,
    textAlign: TextAlign.center,
    textMaxLines: 3,
    textOverflow: TextOverflow.ellipsis,
  );
}

String formatDate(DateTime value) {
  final df = DateFormat("yyyy-mm-dd hh_MM_ss");
  return df.format(value);
}

String getNewFileName() {
  return "Meme Life - ${formatDate(DateTime.now())}";
}
