// Экран с подробной информацией о месте

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/text_styles.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;
  const SightDetails({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SightDetailsHeader(sight: sight),
              SightDetailsBody(sight: sight),
            ],
          ),
        ),
      ),
    );
  }
}

class SightDetailsHeader extends StatelessWidget {
  final Sight sight;
  const SightDetailsHeader({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Фото достопримечательности
        Container(
          width: double.infinity,
          height: 360,
          color: Colors.green[200],
        ),

        // Кнопка "Вернуться назад"
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              top: 12,
            ),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SightDetailsBody extends StatelessWidget {
  final Sight sight;
  const SightDetailsBody({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          // Название места
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 24),
            child: Text(
              sight.name,
              maxLines: 2,
              style: AppTextStyles.sightDetailsTitle,
            ),
          ),

          Row(
            children: [
              // Тип места
              Container(
                margin: EdgeInsets.only(right: 16),
                child: Text(
                  sight.type,
                  style: AppTextStyles.sightDetailsType,
                ),
              ),

              // Время работы места
              Container(
                child: Text(
                  "закрыто до 09:00",
                  style: AppTextStyles.sightDetailsWorkingTime,
                ),
              ),
            ],
          ),

          // Описание места
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 24),
            child: Text(
              sight.details,
              style: TextStyle(),
            ),
          ),

          // Кнопка построения маршрута
          Container(
            margin: EdgeInsets.symmetric(vertical: 24),
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.green[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // Разделитель
          Divider(
            color: Color(0xFFEDEEF0),
          ),

          // Кнопки действий
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Кнопка "Запланировать поход"
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                  ),
                ),
              ),

              // Кнопка "Добавить в избранное"
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
