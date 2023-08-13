import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:trap_front/api/constants.dart';
import 'package:trap_front/api/get_persons.dart';
// import 'package:trap_front/models/person.dart';

class PostPerson extends StatefulWidget {
  const PostPerson({super.key});

  @override
  State<PostPerson> createState() => _PostPersonState();
}

class _PostPersonState extends State<PostPerson> {
  final _formKey = GlobalKey<FormState>();
  var person = {};
  var _selectedRole = "I";

  List<DropdownMenuItem<String>> get dropdownRolesItems {
    List<DropdownMenuItem<String>> rolesItems = const [
      DropdownMenuItem(value: "I", child: Text("Titulaire")),
      DropdownMenuItem(value: "T", child: Text("Piègeur")),
      DropdownMenuItem(value: "C", child: Text("Contrôlleur")),
    ];
    return rolesItems;
  }

  void _savePerson() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _postData(person);
    }
  }

  String? _validStringField(value, stringLenght) {
    if (value == null ||
        value.isEmpty ||
        value.trim().length <= 1 ||
        value.trim().length > stringLenght) {
      return 'Must be between 1 and $stringLenght characters.';
    }
    return null;
  }

  void _postData(person) async {
    try {
      http.Response response = await http.post(
        Uri.parse(api_person),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "role": person['role'],
          "email": person['email'],
          "first_name": person['firstName'],
          "last_name": person['lastName'],
          "address": person['address'],
          "zip_code": person['zipCode'],
          "city": person['city'],
          "approval_ref": person['approval_ref'],
        }),
      );

      if (response.statusCode == 201) {
        //   setState(() {
        //     myTodos = [];
        //   });
        const GetPersons();
        //   fetchData();
      } else {
        print('something went wrong');
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new person'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLength: 30,
                        decoration: const InputDecoration(
                          label: Text('Last Name'),
                        ),
                        validator: (value) {
                          return _validStringField(value, 30);
                        },
                        onSaved: (value) {
                          person['lastName'] = value!;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        maxLength: 30,
                        decoration: const InputDecoration(
                          label: Text('First Name'),
                        ),
                        validator: (value) {
                          return _validStringField(value, 30);
                        },
                        onSaved: (value) {
                          person['firstName'] = value!;
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  maxLength: 300,
                  decoration: const InputDecoration(
                    label: Text('Address'),
                  ),
                  validator: (value) {
                    return _validStringField(value, 300);
                  },
                  onSaved: (value) {
                    person['address'] = value!;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLength: 5,
                        decoration: const InputDecoration(
                          label: Text('Zip Code'),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Must be a valid positive number.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          person['zipCode'] = int.parse(value!);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text('City'),
                        ),
                        validator: (value) {
                          return _validStringField(value, 50);
                        },
                        onSaved: (value) {
                          person['city'] = value!;
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  maxLength: 200,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    person['email'] = value!;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          isDense: true,
                          labelText: 'Role',
                        ),
                        value: _selectedRole,
                        items: dropdownRolesItems,
                        onChanged: (value) {
                          setState(() {
                            _selectedRole = value!;
                          });
                        },
                        onSaved: (value) {
                          person['role'] = value!;
                        },
                      ),
                    ),
                    if (_selectedRole == 'T') ...[
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('N°'),
                          ),
                          validator: (value) {
                            return _validStringField(value, 50);
                          },
                          onSaved: (value) {
                            person['approval_ref'] = value!;
                          },
                        ),
                      ),
                    ]
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: _savePerson,
                      child: const Text('Add Person'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
