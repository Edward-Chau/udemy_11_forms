import 'package:flutter/material.dart';
import 'package:udemy_11/deta/categories.dart';
import 'package:udemy_11/models/category.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _formkey = GlobalKey<FormState>();
  void saveItem() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      print(selecedCategory);
    }
  }

  String? enterName;
  int enterQuantity = 1;
  var selecedCategory = categories[Categories.vegetables]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  //'value.isEmpty' for empty string
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'nmae must between 1 and 50 characters.';
                  }
                  return null;
                },
                autofocus: true,
                maxLength: 50,
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (newValue) {
                  enterName = newValue;
                }, //will trigger when' _formkey.currentState!.save()' is run;
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: const InputDecoration(labelText: 'quantity'),
                      initialValue: enterQuantity.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            //will stop in here if value is null
                            int.tryParse(value)! <= 0) {
                          return 'plz enter anumber';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        enterQuantity = int.parse(newValue!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<Category>(
                      value: selecedCategory,
                      items: [
                        ...categories.entries.map(
                          (item) {
                            return DropdownMenuItem(
                              value: item.value,
                              child: Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: item.value.color,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(item.value.title),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selecedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formkey.currentState!.reset();
                    },
                    child: const Text('Reset'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: saveItem,
                    child: const Text('Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
