import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class TDateOfBirthUpdate extends StatefulWidget {
  const TDateOfBirthUpdate({super.key, this.date_of_birth});

  final String? date_of_birth;

  @override
  _TDateOfBirthUpdateState createState() => _TDateOfBirthUpdateState();
}

class _TDateOfBirthUpdateState extends State<TDateOfBirthUpdate> {
  DateTime? _selectedDate;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _initializeDate();
  }

  void _initializeDate() {
    if (widget.date_of_birth != null && widget.date_of_birth!.isNotEmpty) {
      try {
        // Attempt to parse the date string
        _selectedDate = DateTime.parse(widget.date_of_birth!);
      } catch (e) {
        // Handle invalid date formats
        _selectedDate =
            DateTime.now(); // Default to current date if parsing fails
      }
    } else {
      // Default to current date if date_of_birth is null or empty
      _selectedDate = DateTime.now();
    }
    _dateController = TextEditingController(
      text: _formatDate(_selectedDate),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    // Format date as YYYY-MM-DD
    return '${date.toLocal()}'.split(' ')[0];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime(1971),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text =
            _formatDate(_selectedDate); // Update controller text
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Date of Birth",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please Select your date of birth",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.defaultSpace,
            ),
            SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: () {}, child: const Text("Save")),
            )
          ],
        ),
      ),
    );
  }
}
