import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário de Telefone',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Formulário de Telefone'),
        ),
        body: PhoneNumberForm(),
      ),
    );
  }
}

class PhoneNumberForm extends StatefulWidget {
  @override
  _PhoneNumberFormState createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  final _formKey = GlobalKey<FormState>();
  late String _phoneNumber;

  void _submitPhoneNumber() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Aqui você pode fazer algo com o número de telefone inserido
      print('Número de telefone: $_phoneNumber');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Digite o número de telefone',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira um número de telefone';
              }
              return null;
            },
            onSaved: (value) {
              _phoneNumber = value!;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitPhoneNumber,
            child: Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
