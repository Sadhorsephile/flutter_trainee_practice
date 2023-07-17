import 'package:draggable_notes/res/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemePickerDialog extends StatelessWidget {
  final void Function(ThemeMode?) onThemeChanged;

  const ThemePickerDialog({
    super.key,
    required this.onThemeChanged,
  });

  void onChange(BuildContext context, ThemeMode? theme) {
    onThemeChanged(theme);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Выберете тему',
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
                Text('Светлая'),
              ],
            ),
            Row(
              children: [
                Radio<ThemeMode>(
                  value: ThemeMode.dark,
                  groupValue: context.watch<ThemeProvider>().currentThemeMode,
                  onChanged: (theme) => onChange(context, theme),
                ),
                Text('Темная'),
              ],
            ),
            Row(
              children: [
                Radio<ThemeMode>(
                  value: ThemeMode.system,
                  groupValue: context.watch<ThemeProvider>().currentThemeMode,
                  onChanged: (theme) => onChange(context, theme),
                ),
                Text('Системная'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
