import 'package:aquarium/res/styles.dart';
import 'package:flutter/material.dart';

class UserLogWidget extends StatelessWidget {
  final List<String>? logList;
  final ScrollController controller;

  const UserLogWidget({
    required this.logList,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
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
      ),
    );
  }
}
