import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'wa_me.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Link Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('WhatsApp Link Generator'),
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.all(16),
            child: FormWhatsapp(),
          ),
        ),
      ),
    );
  }
}
