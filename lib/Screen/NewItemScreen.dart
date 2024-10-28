import 'package:flutter/material.dart';
import 'package:udemy_11/deta/categories.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _formkey=GlobalKey();
  void saveItem() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(key: _formkey,
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
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: const InputDecoration(labelText: 'quantity'),
                      initialValue: '1',
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
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      items: [
                        ...categories.entries.map(
                          (item) {
                            return DropdownMenuItem(
                              value: categories.values,
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
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
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
