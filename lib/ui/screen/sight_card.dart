import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/colors.dart';

class SightCard extends StatelessWidget {
  final Sight sight;
  const SightCard({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: Container(
          constraints: BoxConstraints(maxHeight: 210),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SightCardHeader(sight: sight),
              SightCardBody(sight: sight),
            ],
          ),
        ),
      ),
    );
  }
}

class SightCardHeader extends StatelessWidget {
  final Sight sight;
  const SightCardHeader({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Главное фото места
        Container(
          height: 96,
          child: Image.network(
            sight.url,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        // Тип места
        Positioned(
          top: 16,
          left: 16,
          child: Text(
            sight.type,
            style: AppTextStyles.sightCardType,
          ),
        ),

        // Добавить в избранное
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            width: 20,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}

class SightCardBody extends StatelessWidget {
  final Sight sight;
  const SightCardBody({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 114),
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Отступ
          const SizedBox(
            height: 18,
          ),

          // Название места
          Container(
            color: AppColors.sightCardName,
            constraints: const BoxConstraints(
              maxWidth: 151,
              maxHeight: 62,
            ),
            padding: EdgeInsets.only(left: 3, right: 9),
            child: Text(
              sight.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.sightCardTitle,
            ),
          ),

          const SizedBox(
            height: 2,
          ),

          // Время работы
          Container(
            child: Text(
              sight.workingTime,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.sightCardWorkingTime,
            ),
          ),
        ],
      ),
    );
  }
}
