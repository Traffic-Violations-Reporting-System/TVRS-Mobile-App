

import 'package:etrafficcomplainer/core/widget/custom_dialog_2.dart';
import 'package:flutter/material.dart';

class CustomDialogHelper {

    final popupBarrierColor = Color(0xFF151929).withOpacity(0.4);

    void showCustomDialog2(context) => showDialog(context: context, barrierColor: popupBarrierColor, builder: (context) => CustomDialog2());
}