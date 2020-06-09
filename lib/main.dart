import 'package:final_binder/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          home: Wrapper()
      ),
    );
  }
}
