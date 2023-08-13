import 'package:flutter/material.dart';

// import 'package:trap_front/widgets/persons_container.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trap_front/models/person.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Person> persons = [];
  bool isLoading = true;
  void fetchData() async {
    try {
      const String api = 'http://10.0.2.2:8000/person/';
      http.Response response = await http.get(
        Uri.parse(api),
      );
      var data = json.decode(response.body);
      data.forEach((person) {
        Person p = Person(
          id: person['id'],
          role: person['role'],
          email: person['email'],
          firstName: person['first_name'],
          lastName: person['last_name'],
          address: person['address'],
          zipCode: person['zip_code'],
          city: person['city'],
          approvalRef: person['approval_ref'],
        );
        persons.add(p);
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      print("Error du fetch : $e");
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Django Trap")),
      // body: Column(children: [
      //   isLoading
      //       ? const CircularProgressIndicator()
      //       : Column(
      //           children: persons.map((e) {
      //           return PersonsContainer(
      //             id: e.id,
      //             role: e.role,
      //             email: e.email,
      //             lastName: e.lastName,
      //             firstName: e.firstName,
      //             address: e.address,
      //           );
      //         }).toList()),
      // ]),
    );
  }
}
