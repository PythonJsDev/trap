import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trap_front/api/post_person.dart';
import 'package:trap_front/models/person.dart';
import 'package:trap_front/widgets/circular_progress.dart';
import 'package:trap_front/screens/persons_screen.dart';
import 'package:trap_front/api/constants.dart';

class GetPersons extends StatefulWidget {
  const GetPersons({super.key});
  @override
  State<GetPersons> createState() => _GetPersonsState();
}

class _GetPersonsState extends State<GetPersons> {
  List<Person> persons = [];
  bool isLoading = true;

  String _getRole(role) {
    if (role == 'T') {
      return 'Piègeur';
    }
    if (role == 'I') {
      return 'Titulaire';
    }
    return 'Controlleur';
  }

  String _capitalize(text) => '${text[0].toUpperCase()}${text.substring(1)}';

  void _addPerson() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const PostPerson()),
    );
  }

  void getPersons() async {
    try {
      http.Response response = await http.get(
        Uri.parse(api_person),
      );
      var data = json.decode(response.body);
      data.forEach(
        (person) {
          Person p = Person(
            id: person['id'],
            role: _getRole(person['role']),
            email: person['email'],
            firstName: _capitalize(person['first_name']),
            lastName: person['last_name'].toUpperCase(),
            address: person['address'],
            zipCode: person['zip_code'],
            city: person['city'],
            approvalRef: person['approval_ref'],
          );
          persons.add(p);

          setState(
            () {
              isLoading = false;
            },
          );
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    getPersons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Persons"),
        actions: [
          IconButton(
            onPressed: _addPerson,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: isLoading
              ? const CircularProgress()
              : Column(children: [
                  for (final person in persons) PersonsScreen(person: person)
                ]
                  // alternative à la boucle for ci-dessus:
                  // children: persons.map((person) {
                  //   return PersonsScreen(person: person);
                  // }).toList(),
                  ),
        ),
      ),
    );
  }
}
