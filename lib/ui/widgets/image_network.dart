import 'package:flutter/material.dart';
import 'package:places/res/durations.dart';
import 'package:places/res/images.dart';

/// Widget for easy loading of images from network.
/// Accepts [url] - a link to a picture.
/// Displays the placeholder at boot time.
class ImageNetwork extends StatelessWidget {
  final String url;

  const ImageNetwork(
    this.url, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: _placeholder(),
        ),
        Container(
          width: double.infinity,
          child: Image.network(
            url,
            fit: BoxFit.cover,
            frameBuilder: (context, Widget child, int frame, _) {
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: AppDurations.imageDownloading,
                curve: Curves.easeIn,
                child: child,
              );
            },
            errorBuilder: (context, error, stackTrace) => _placeholder(),
          ),
        ),
      ],
    );
  }

  Widget _placeholder() {
    return Image.asset(
      AppImages.placeholder,
    );
  }
}
