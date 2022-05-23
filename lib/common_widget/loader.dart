import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universal_platform/universal_platform.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(UniversalPlatform.isIOS){
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
