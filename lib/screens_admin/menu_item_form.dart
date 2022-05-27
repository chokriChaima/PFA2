
import 'package:flutter/material.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/AppColors.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/BigText.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/SmallText.dart';
import 'package:pfa2_mobile_app/customs/sharedWidgets/component_name_field.dart';
import 'package:pfa2_mobile_app/models/menu_item.dart';
import 'package:pfa2_mobile_app/screens_admin/menu_form.dart';

class MenuItemForm extends StatefulWidget {
  const MenuItemForm({Key? key}) : super(key: key);

  @override
  State<MenuItemForm> createState() => _MenuItemFormState();
}

class _MenuItemFormState extends State<MenuItemForm> {

 

  //  Inputs Controllers
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController maxReservationController =
      TextEditingController();
  final TextEditingController availabilityDateController =
      TextEditingController();

  // components
  List<ComponentNameField> components = [
    ComponentNameField(),
  ];

  List<String> componentsElements = [];

  DateTime _date = DateTime.now();
  bool _isLunch = false;
  @override
  Widget build(BuildContext context) {
    // Input Fields
    final titleField = TextFormField(
      style: const TextStyle(
        fontSize: 18,
        height: 0.4,
      ),
      textAlign: TextAlign.center,
      autofocus: false,
      controller: titleController,
      validator: (value) {
        if (value!.isEmpty) return ("Please enter a title");
        return null;
      },
      onSaved: (value) => titleController.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          //  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Title",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor))),
    );

    final maxReservationField = TextFormField(
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18,
        height: 0.4,
      ),
      autofocus: false,
      controller: maxReservationController,
      validator: (value) {
        if (value!.isEmpty) return ("Please specify a number");
        return null;
      },
      onSaved: (value) => maxReservationController.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          //  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Maximum number of reservation",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor))),
    );

    final availablilityDateField = TextFormField(
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18,
        height: 0.4,
      ),
      controller:
          availabilityDateController, //editing controller of this TextField
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_today), //icon of text field
          hintText:
              "Availability date :   ${_date.year}-${_date.month}-${_date.day}",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor))),
      readOnly: true, //set to true, so that user will not able to edit text
      onTap: () async {
        setState(() {
          _selectDate(context);
        });
      },
    );

    final componentsSection = Container(
        padding: const EdgeInsets.fromLTRB(40, 8, 20, 0),
        // add listview builder.
        child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
                  height: 15,
                ),
            itemCount: components.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  components[index],
                  IconButton(
                    icon: const Icon(Icons.delete_rounded),
                    onPressed: () {
                      deleteComponent(index);
                    },
                  ),
                ],
              );
            }));

    final addButton = ElevatedButton(
        onPressed: () {
          submitForm();
        },
        child: SmallText(
          text: "Add to current menu",
          color: AppColors.backgroundWhite,
          size: 18,
        ));

    

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BigText(
            text: "Menu Item Form",
            color: AppColors.mainColor,
          ),
          leading: BackButton(color: AppColors.mainColor),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: BigText(
                  text: "Create and customise your menu item",
                  fontweight: FontWeight.bold,
                ),
                padding: const EdgeInsets.only(left: 7, top: 40),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 28,
                        ),
                        titleField,
                        const SizedBox(
                          height: 28,
                        ),
                        maxReservationField,
                        const SizedBox(
                          height: 28,
                        ),
                        availablilityDateField,
                        const SizedBox(
                          height: 11,
                        ),
                        SmallText(
                          text:
                              "This item will become available to the public according to this date",
                          color: AppColors.textColor,
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                title: SmallText(
                                  text: "Lunch",
                                  color: AppColors.textColor,
                                  size: 16,
                                ),
                                leading: Radio(
                                    activeColor: AppColors.mainColor,
                                    value: true,
                                    groupValue: _isLunch,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isLunch = value!;
                                      });
                                    }),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: SmallText(
                                  text: "Dinner",
                                  color: AppColors.textColor,
                                  size: 16,
                                ),
                                leading: Radio(
                                    activeColor: AppColors.mainColor,
                                    value: false,
                                    groupValue: _isLunch,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isLunch = value!;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        BigText(text: "Pick your menu item components"),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: TextButton(
                            onPressed: () {
                              addComponent();
                            },
                            child: SmallText(
                              text: "Add component",
                              color: AppColors.mainColor,
                              size: 17,
                              underline: true,
                            ),
                          ),
                        ),
                        componentsSection,
                        const SizedBox(height: 22),
                        SizedBox(width :330 ,height :48,child: addButton),   
                        const SizedBox(height: 20),
                      ]),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _selectDate(
    BuildContext context,
  ) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
          2000), //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2101),
    );
    if (_datePicker != null) {
      setState(() {
        _date = _datePicker;
      });
    }
  }

  // Components Managmement
  void addComponent() {
    components.add(ComponentNameField());
    setState(() {});
  }

  void deleteComponent(int index) {
    components.removeAt(index);
    setState(() {});
  }

  Future<void> submitForm() async{
    
    if (_formKey.currentState!.validate()) {
      MenuItem menuItem = MenuItem(
          isLunch: _isLunch,
          components: componentsElements,
          title: titleController.text,
          maxReservationNumber: int.parse(maxReservationController.text),
          availabilityDate: _date);

      for (ComponentNameField element in components) {
        componentsElements.add(element.componentNameController.text);
      }

      Navigator.pop(context,menuItem);
      // Navigator.push(context, MaterialPageRoute(builder:(context) => MenuForm(newMenuItem : menuItem) ));
    }
  }

  
}
