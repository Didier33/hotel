// widgets/signature_pad.dart
import 'dart:typed_data'; // ✅ Ajouté pour Uint8List
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignaturePad extends StatefulWidget {
  final Function(Uint8List?) onSignatureSaved;

  const SignaturePad({super.key, required this.onSignatureSaved});

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Signature(
            controller: _controller,
            height: 200,
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                _controller.clear();
              },
              icon: Icon(Icons.clear, size: 18),
              label: Text("Effacer"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                if (_controller.isNotEmpty) {
                  final data =
                      await _controller.toPngBytes(); // Retourne Uint8List?
                  widget.onSignatureSaved(data);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Signature enregistrée")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Dessinez d'abord une signature")),
                  );
                }
              },
              icon: Icon(Icons.save, size: 18),
              label: Text("Sauvegarder"),
            ),
          ],
        ),
      ],
    );
  }
}
