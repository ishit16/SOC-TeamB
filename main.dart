import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Flutter Contacts'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}): super(key:key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllContacts();
    searchController.addListener((){
      filterContacts();
    });
  }

  String flattenPhoneNumber(String phoneStr){
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m){
      return m[0]== '+' ? '+' : '';
    });
  }

  getAllContacts() async{
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    setState((){
      contacts = _contacts;
    });
  }

  filterContacts(){
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty){
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = searchController.text.toLowerCase();
        String contactName = contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if(searchTermFlatten.isEmpty){
          return false;
        }
        var phone = contact.phones.firstWhere((phn){
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse:() => null);
        return phone != null;

      });

      setState((){
        contactsFiltered = _contacts;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'Search',
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: Theme.of(context).primaryColor
                      ),
                    ),
                    prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor
                    )
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: isSearching == true ? contactsFiltered.length : contacts.length,
                itemBuilder: (context, index){
                  Contact contact = isSearching == true ? contactsFiltered[index] : contacts[index];
                  return ListTile(
                      title: Text(contact.displayName),
                      subtitle: Text(
                          contact.phones.elementAt(0).value
                      ),
                      leading: (contact.avatar != null && contact.avatar.length > 0)?
                      CircleAvatar(
                        backgroundImage: MemoryImage(contact.avatar),
                      ):
                      CircleAvatar(child: Text(contact.initials()))
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}