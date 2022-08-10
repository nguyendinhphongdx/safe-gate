
import 'package:flutter/material.dart';

class UndefinedLayout extends StatelessWidget {
  final String? name;
  const UndefinedLayout({this.name,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(name ?? ''));
  }
}
