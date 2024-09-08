import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TGenderUpdateScreen extends StatefulWidget {
  const TGenderUpdateScreen({
    super.key,
    required this.fieldValue,
  });

  final String fieldValue;

  @override
  _TGenderUpdateScreenState createState() => _TGenderUpdateScreenState();
}

class _TGenderUpdateScreenState extends State<TGenderUpdateScreen> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.fieldValue;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: dark ? Colors.white : Colors.black),
        backgroundColor: dark ? Colors.black : Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gender",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.defaultSpace,
            ),
            Text(
              "Update Your Gender",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: TSizes.appBarHeight - 10,
            ),
            DropdownButtonFormField<String>(
              value: _selectedValue,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedValue = value;
                  });
                }
              },
              items: <String>['Male', 'Female'].map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.user),
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please select a value'
                  : null,
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
