import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      home: ContactList(),
    );
  }
}

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final List<Contact> contacts = [
    Contact('John Doe', 'johndoe@gmail.com', '123-456-7890'),
    Contact('Jane Doe', 'janedoe@gmail.com', '987-654-3210'),
    Contact('Mike Smith', 'mikesmith@gmail.com', '555-555-5555'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.email),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ContactDetails(contact: contact);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class Contact {
  final String name;
  final String email;
  final String phone;

  Contact(this.name, this.email, this.phone);
}

class ContactDetails extends StatelessWidget {
  final Contact contact;

  ContactDetails({this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            contact.name,
            style: TextStyle(fontSize: 20.0),
          ),
          Text(contact.email),
          Text(contact.phone),
        ],
      ),
    );
  }
}
