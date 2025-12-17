import 'package:flutter/material.dart';
import 'package:ai_quiz_generator/theme/app_theme.dart';

class QuizRadioGroup extends StatelessWidget {
  final List<String> options;
  final String? value;
  final ValueChanged<String> onChanged;
  final EdgeInsetsGeometry padding;

  const QuizRadioGroup({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.padding = const EdgeInsets.symmetric(vertical: 4.0),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        final selected = option == value;
        return Padding(
          padding: padding,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => onChanged(option),
            child: Container(
              decoration: BoxDecoration(
                color: selected ? AppTheme.primaryAppExtraLight : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected
                      ? AppTheme.primaryApp
                      : const Color(0xFFE3E8EF),
                  width: selected ? 2 : 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: selected
                        ? AppTheme.primaryApp
                        : const Color(0xFF5C6B7A),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color(0xFF2C3E50),
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
