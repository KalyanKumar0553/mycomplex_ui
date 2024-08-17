import 'package:flutter/material.dart';
import 'package:mycomplex_ui/widgets/custom_text_field.dart';
import '../../../colors.dart';
class ProfileBioTab extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController genderController;
  final TextEditingController dobController;
  final TextEditingController anniversaryController;
  final TextEditingController bloodGroupController;
  final TextEditingController govtIdController;
  final VoidCallback onSave;

  const ProfileBioTab({
    Key? key,
    required this.nameController,
    required this.genderController,
    required this.dobController,
    required this.anniversaryController,
    required this.bloodGroupController,
    required this.govtIdController,
    required this.onSave,
  }) : super(key: key);

  @override
  _ProfileBioTabState createState() => _ProfileBioTabState();
}

class _ProfileBioTabState extends State<ProfileBioTab> {

  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.genderController.text ?? '';
  }


  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        controller.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
            children: [
              CustomTextField(
                  labelText: 'Name *',
                  controller: widget.nameController,
                  isPassword: false,
              ),
              const SizedBox(height: 4),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Theme(             
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(primary: AppColors.primary),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      dropdownColor: AppColors.textColor,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: AppColors.inputLabelColor),
                        filled: true,
                        fillColor: AppColors.inputFillColor,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Gender',
                      ),
                      items: const [
                        DropdownMenuItem(value: '', child: Text('Please Select Gender',style: TextStyle(color:AppColors.textColor),)),
                        DropdownMenuItem(value: 'Male', child: Text('Male',style: TextStyle(color:AppColors.textColor),)),
                        DropdownMenuItem(value: 'Female', child: Text('Female',style: TextStyle(color:AppColors.textColor),)),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                          widget.genderController.text = newValue!;
                        });
                      },
                    ),
                  ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:TextField(
                  controller: widget.dobController,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      filled: true,
                      fillColor: AppColors.inputFillColor,
                      suffixIcon: Icon(Icons.calendar_today),
                      labelStyle: const TextStyle(color: AppColors.inputLabelColor),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context, widget.dobController),
                )
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:TextField(
                  controller: widget.anniversaryController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.inputFillColor,
                      labelText: 'Anniversary Date',
                      suffixIcon: Icon(Icons.calendar_today),
                      labelStyle: const TextStyle(color: AppColors.inputLabelColor),
                      border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context, widget.anniversaryController),
                )
              ),
              const SizedBox(height: 4),
              CustomTextField(
                  labelText: 'Blood group ',
                  controller: widget.bloodGroupController,
                  isPassword: false,
              ),
              const SizedBox(height: 4),
              CustomTextField(
                  labelText: 'Government ID ',
                  controller: widget.govtIdController,
                  isPassword: false,
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: widget.onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Done', style: TextStyle(color: AppColors.background)),
              ),
            ],
          ),
      ),
      ),
    );
  }
}
