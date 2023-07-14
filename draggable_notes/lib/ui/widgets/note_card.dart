import 'package:draggable_notes/res/colors.dart';
import 'package:flutter/material.dart';

/// Карточка с заметкой
class NoteCard extends StatelessWidget {
  final String title;
  final String content;

  const NoteCard({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 100,
          minWidth: double.infinity,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 10,
                  top: 16,
                ),
                child: Text(content),
              )
            ],
          ),
        ),
      ),
    );
  }
}
