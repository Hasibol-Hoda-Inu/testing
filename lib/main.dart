import 'package:flutter/material.dart';

void main() {
  runApp(ContactListApp());
}

class ContactListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List App',
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatelessWidget {
  // Sample contact list data
  final List<Contact> contacts = [
    Contact('John Snow', 'john.snow@example.com', '1234567890'),
    Contact('Jane Austen', 'jane.austen@example.com', '9876543210'),
    Contact('Mike Dean', 'mike.dean@example.com', '5555555555'),
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
            onTap: () => _showContactDetails(context, contact),
          );
        },
      ),
    );
  }

  void _showContactDetails(BuildContext context, Contact contact) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Name: ${contact.name}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Email: ${contact.email}'),
              SizedBox(height: 8),
              Text('Phone: ${contact.phone}'),
            ],
          ),
        );
      },
    );
  }
}

class Contact {
  final String name;
  final String email;
  final String phone;

  Contact(this.name, this.email, this.phone);
}