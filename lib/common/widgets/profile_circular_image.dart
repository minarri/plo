import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; 

class DefaultProfileImageWidget extends StatefulWidget {
  static const String defaultImageurl = "default_profile_pic";
  final String imageUrl;
  final double radius;
  const DefaultProfileImageWidget({super.key, required this.imageUrl, this.radius = 30});

  @override
  State<DefaultProfileImageWidget> createState() => _DefaultImageWidgetState();
}

class _DefaultImageWidgetState extends State<DefaultProfileImageWidget> {
  bool isImageError = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius * 2,
      height: widget.radius * 2,
      child: ClipOval(
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[250]),
          child: widget.imageUrl == DefaultProfileImageWidget.defaultImageurl
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset("assets/images/profile_default.png"),
                )
              : ClipOval(
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.error, size: 20),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
