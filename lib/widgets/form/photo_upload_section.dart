// widgets/form/photo_upload_section.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUploadSection extends StatelessWidget {
  final String title;
  final String type; // 'recto' ou 'verso'
  final Function(ImageSource, String) onImageSelected;

  const PhotoUploadSection({
    super.key,
    required this.title,
    required this.type,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => onImageSelected(ImageSource.camera, type),
                icon: Icon(Icons.camera_alt, size: 18),
                label: Text("Appareil"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => onImageSelected(ImageSource.gallery, type),
                icon: Icon(Icons.image, size: 18),
                label: Text("Galerie"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
