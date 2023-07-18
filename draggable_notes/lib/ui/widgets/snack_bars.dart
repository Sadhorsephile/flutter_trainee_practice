import 'package:draggable_notes/res/colors.dart';
import 'package:draggable_notes/res/strings.dart';
import 'package:flutter/material.dart';

/// Снэкбар для оповещения пользователя о том,
/// что не удалось загрузить данные.
class ErrorSnackBar extends SnackBar {
  /// Действие по нажатию
  final void Function() onActionTap;

  ErrorSnackBar({
    required this.onActionTap,
    super.key,
  }) : super(
          duration: const Duration(seconds: 10),
          backgroundColor: AppColors.errorColor,
          content: const Text(
            AppStrings.loadingError,
          ),
          action: SnackBarAction(
            label: AppStrings.refresh,
            onPressed: onActionTap,
          ),
        );
}
