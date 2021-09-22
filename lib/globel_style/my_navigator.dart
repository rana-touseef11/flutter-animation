import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future myNavigator(BuildContext context, Widget Function(BuildContext) onTap) {
  return Navigator.push(context, MaterialPageRoute(builder: onTap)).then((value) => null);
}
