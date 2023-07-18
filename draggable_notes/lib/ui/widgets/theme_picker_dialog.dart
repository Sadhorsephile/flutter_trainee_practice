import 'package:draggable_notes/providers/theme_provider.dart';
import 'package:draggable_notes/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Диалог выбора темы
class ThemePickerDialog extends StatelessWidget {
  final void Function(ThemeMode?) onThemeChanged;

  const ThemePickerDialog({
    required this.onThemeChanged,
    super.key,
  });

  void onChange(BuildContext context, ThemeMode? theme) {
    onThemeChanged(theme);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        AppStrings.chooseThemeMode,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            Row(
              children: [
                Radio<ThemeMode>(
                  value: ThemeMode.light,
                  groupValue: context.watch<ThemeProvider>().currentThemeMode,
                  onChanged: (theme) => onChange(context, theme),
                ),
                const Text(AppStrings.lightThemeMode),
              ],
            ),
            Row(
              children: [
                Radio<ThemeMode>(
                  value: ThemeMode.dark,
                  groupValue: context.watch<ThemeProvider>().currentThemeMode,
                  onChanged: (theme) => onChange(context, theme),
                ),
                const Text(AppStrings.darkThemeMode),
              ],
            ),
            Row(
              children: [
                Radio<ThemeMode>(
                  value: ThemeMode.system,
                  groupValue: context.watch<ThemeProvider>().currentThemeMode,
                  onChanged: (theme) => onChange(context, theme),
                ),
                const Text(AppStrings.systemThemeMode),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
