import 'package:draggable_notes/res/colors.dart';
import 'package:draggable_notes/res/strings.dart';
import 'package:flutter/material.dart';

/// Снэкьар для оповещения пользователя о том,
/// что не удалось загрузить данные.
final errorLoadingSnackBar = SnackBar(
  backgroundColor: AppColors.errorColor,
  content: const Text(
    AppStrings.loadingError,
  ),
);
