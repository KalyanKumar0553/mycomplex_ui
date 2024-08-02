import 'package:flutter/material.dart';
import '../../colors.dart';

class AddDailyHelpDialog extends StatelessWidget {
  const AddDailyHelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Add Daily Help',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Please ensure that you have spoken to him/her before adding this person to the flat.',
              textAlign: TextAlign.center,
              style: TextStyle(color:AppColors.textColor),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.textColor),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textColor,
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(
                height: 50,
                child: VerticalDivider(
                  width: 1,
                  color: AppColors.textColor,
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColors,
                    foregroundColor: AppColors.textColor,
                    minimumSize: const Size.fromHeight(50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}