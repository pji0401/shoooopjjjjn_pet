import 'package:flutter/material.dart';
import 'package:pawprints/config/index.dart';

class GenderPicker extends StatelessWidget {
  final String selectedGender;
  final void Function(String gender) onGenderSelected;

  const GenderPicker({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildOption('남자', 'male'),
          _buildOption('여자', 'female'),
        ],
      ),
    );
  }

  Widget _buildOption(String label, String value) {
    final isSelected = selectedGender == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => onGenderSelected(value),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isSelected
                ? Border.all(color: AppColors.main, width: 1.5)
                : Border.all(color: Colors.transparent),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Pretendard',
              color: isSelected ? AppColors.main : AppColors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}