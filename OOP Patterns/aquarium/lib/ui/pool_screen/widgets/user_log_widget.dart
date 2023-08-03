import 'package:aquarium/res/styles.dart';
import 'package:flutter/material.dart';

/// Виджет пользовательских логов
class UserLogWidget extends StatelessWidget {
  /// Список логов
  final List<String>? logList;

  /// Контроллер для скрола
  final ScrollController controller;

  const UserLogWidget({
    required this.logList,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView.builder(
        controller: controller,
        itemCount: logList?.length,
        itemBuilder: (_, i) {
          if (logList != null) {
            return Text(
              logList![i],
              style: AppStyles.userLogStyle,
            );
          }
          return null;
        },
      ),
    );
  }
}
