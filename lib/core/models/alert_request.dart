import 'package:flutter/material.dart';

import 'food_model.dart';

class AlertRequest {
  final String title;
  final String description;
  final String buttonTitle;
  final String typeAlert;
  final FoodModel food;

  AlertRequest({
    @required this.title,
    @required this.description,
    @required this.buttonTitle,
    @required this.typeAlert,
    this.food
  });
}