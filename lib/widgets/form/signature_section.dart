// lib/widgets/signature_pad.dart
import 'dart:typed_data';
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
          height: 180,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Signature(
            controller: _controller,
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () => _controller.clear(),
              icon: Icon(Icons.clear, size: 16),
              label: Text("Effacer"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                if (_controller.isNotEmpty) {
                  final data = await _controller.toPngBytes();
                  widget.onSignatureSaved(data);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Veuillez signer.")),
                  );
                }
              },
              icon: Icon(Icons.save, size: 16),
              label: Text("Sauvegarder"),
            ),
          ],
        ),
      ],
    );
  }
}
