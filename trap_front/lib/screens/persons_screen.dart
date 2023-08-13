import 'package:flutter/material.dart';
import 'package:trap_front/models/person.dart';
import 'package:trap_front/screens/person_details_screen.dart';

class PersonsScreen extends StatelessWidget {
  const PersonsScreen({
    super.key,
    required this.person,
  });

  final Person person;

  void _selectPerson(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PersonDetailsScreen(person: person),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectPerson(context);
      },
      splashColor: Theme.of(context).primaryColor,
      child: Card(
        // color: Colors.yellow,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),

        // clipBehavior: Clip.hardEdge,
        // elevation: 2,
       
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${person.firstName} ${person.lastName}',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: 6),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  person.role,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  // style: const TextStyle(
                  //   color: Colors.grey,
                  //   fontWeight: FontWeight.normal,
                  //   fontSize: 15,
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
