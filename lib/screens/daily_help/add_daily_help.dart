import 'package:flutter/material.dart';
import '../../colors.dart';

class AddDailyHelpDialog extends StatelessWidget {
  const AddDailyHelpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.onPrimary,
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
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Please ensure that you have spoken to him/her before adding this person to the flat.',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Colors.grey),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
              Container(
                height: 50,
                child: const VerticalDivider(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow, // background (button) color
                    foregroundColor: Colors.black, // text (button) color
                  ),
                  onPressed: () {
                    // Add your logic here
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
