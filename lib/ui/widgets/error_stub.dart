import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/text_styles.dart';

/// [The [ErrorStub] widget displays a stub,
/// when the list or screen is empty.
/// [icon] - icon in svg format.
/// [title] - stub title.
/// [subtitle] - additional text under the title.
class ErrorStub extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  const ErrorStub({
    Key key,
    this.icon,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            this.icon,
            width: 64,
            height: 64,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.emptyPageTitle.copyWith(
              color: Theme.of(context).disabledColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.emptyPageSubtitle.copyWith(
              color: Theme.of(context).disabledColor,
            ),
          )
        ],
      ),
    );
  }
}
