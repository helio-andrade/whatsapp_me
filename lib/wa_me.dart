import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormWhatsapp extends StatefulWidget {
  const FormWhatsapp({super.key});

  @override
  _FormWhatsappState createState() => _FormWhatsappState();
}

class _FormWhatsappState extends State<FormWhatsapp> {
  final _formKey = GlobalKey<FormState>();
  late String _numero;
  late String _mensagem;
  String _countryCode = 'BR';
  late String _linkGerado;

  void _gerarLink() {
    if (_formKey.currentState == null) return;

    if (_formKey.currentState!.validate()) {
      final mensagemParam = _mensagem != null ? '?text=$_mensagem' : '';
      _linkGerado = 'https://wa.me/$_countryCode$_numero$mensagemParam';
    }
  }

  void _copiarLink() {
    Clipboard.setData(ClipboardData(text: _linkGerado));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Link copiado para a área de transferência')),
    );
  }

  void _refazerLink() {
    setState(() {
      _numero = "";
      _mensagem = "";
      _linkGerado = "";
      _countryCode = 'BR';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Informe o número do seu WhatsApp:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _countryCode,
                    onChanged: (value) {
                      setState(() {
                        _countryCode = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'BR',
                        child: Text('Brasil (+55)'),
                      ),
                      DropdownMenuItem(
                        value: 'PT',
                        child: Text('Portugal (+351)'),
                      ),
                      DropdownMenuItem(
                        value: 'US',
                        child: Text('USA (+1)'),
                      ),
                      DropdownMenuItem(
                        value: 'DZ',
                        child: Text('Algeria (+213)'),
                      ),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '(99) 99999-9999',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, informe um número de telefone';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _numero = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Mensagem (opcional):',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Digite algo para iniciar a conversa',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _mensagem = value;
              });
            },
          ),
          if (_linkGerado == null)
            SizedBox()
          else
            Column(
              children: [
                Text(
                  _linkGerado,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _linkGerado));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Link copiado para área de transferência")));
                      },
                      child: Text('COPIAR'),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        initialValue: _linkGerado,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Link personalizado',
                          border: const OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _linkGerado = '';
                    });
                  },
                  child: const Text('Refazer'),
                ),
              ],
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
