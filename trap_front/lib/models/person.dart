class Person {
  final int id;
  final String role;
  final String email;
  final String firstName;
  final String lastName;
  final String address;
  final int zipCode;
  final String city;
  final String approvalRef;

  Person(
      {required this.id,
      required this.role,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.address,
      required this.zipCode,
      required this.city,
      required this.approvalRef});
}
