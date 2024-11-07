import 'package:flutter/material.dart';

class MensagemInput extends StatefulWidget {
  final void Function(String) onSend;

  const MensagemInput({Key? key, required this.onSend}) : super(key: key);

  @override
  _MensagemInputState createState() => _MensagemInputState();
}

class _MensagemInputState extends State<MensagemInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text); // envia a mensagem
      _controller.clear(); // limpa o input após enviar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // margem de 8px
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16), // cantos arredondados de 16px
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null, // permite o campo expandir em altura
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Mensagem',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(), // envia ao pressionar "Enter"
              ),
            ),
            IconButton(
              icon: Image.asset('assets/setaenviar.png'), // caminho da seta
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
