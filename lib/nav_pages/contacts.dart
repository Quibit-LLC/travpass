import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  // A list to store the contacts

  List<Contact> _contacts = [];

  // A method to load the contacts from the device
  void _loadContacts() async {
    // Request contact permission
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      // Get all contacts on device with phone numbers
      List<Contact> contacts = await FlutterContacts.getContacts();

      // Update the state with the contacts
      setState(() {
        _contacts = contacts.toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Load the contacts when the page is initialized
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: _contacts.length, // The number of contacts in the list
        itemBuilder: (context, index) {
          Contact contact = _contacts[index]; // The contact at this index
          return ListTile(
            title: Text(contact.displayName), // The name of the contact
            subtitle: Text(contact.phones.isNotEmpty
                ? contact.phones.first
                    .number // The first phone number of the contact
                : ''), // If there is no phone number, show an empty string
          );
        },
      ),
    );
  }
}
