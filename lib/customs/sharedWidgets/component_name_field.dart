import 'package:flutter/material.dart';

import '../sharedElements/AppColors.dart';
class ComponentNameField extends StatelessWidget {
   
   TextEditingController componentNameController = TextEditingController();

   ComponentNameField({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          height: 0.4,
        ),
        autofocus: false,
        controller: componentNameController,
        validator: (value) {
          if (value!.isEmpty) return ("Please enter a name");
          return null;
        },
        onSaved: (value) => componentNameController.text = value!,
        decoration: InputDecoration(
            hintText: "Component name",
            border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.mainColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.mainColor))),
      ),
    );
  }
}