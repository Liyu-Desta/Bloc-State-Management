import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '/presentation/screens/Profile.dart'; // Import your Profile file
import 'userList.dart';
import '/presentation/screens/LoginPage.dart';
import '/presentation/widgets/HamburgerMenu.dart'; 
import '../widgets/logout_dialog.dart';
import 'package:intl/intl.dart';


// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Dashboard(),
//     routes: {
//       '/dashboard': (context) => Dashboard(),
//       '/profile': (context) => AdminProfilePage(),
//       '/userList': (context) => UserList(),
//       '/loginpage': (context) => LoginScreen(),
//     },
//     onGenerateRoute: (settings) {
//       if (settings.name == '/login') {
//         return MaterialPageRoute(builder: (context) => LoginScreen());
//       }
//       // Handle other routes here if needed
//     },
//   ));
// }

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  DateTime? _date1;
  DateTime? _date2;
  Uint8List? _selectedImage;
  List<Opportunity> opportunities = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _addOpportunity() {
    showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: AlertDialog(
            title: Text('Add Opportunity'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title *'),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration:
                        InputDecoration(labelText: 'Description (Optional)'),
                  ),
                  TextFormField(
                    controller: _locationController,
                    decoration: InputDecoration(labelText: 'Location *'),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _selectDate().then((pickedDate) {
                              if (pickedDate != null) {
                                setState(() {
                                  _date1 = pickedDate;
                                });
                              }
                            });
                          },
                          child: Text('Select Date 1 *'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _selectDate().then((pickedDate) {
                              if (pickedDate != null) {
                                setState(() {
                                  _date2 = pickedDate;
                                });
                              }
                            });
                          },
                          child: Text('Select Date 2 (Optional)'),
                        ),
                      ),
                    ],
                  ),
                  if (_selectedImage != null) SizedBox(height: 16),
                  if (_selectedImage != null)
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Image.memory(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Pick Photo'),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isEmpty ||
                      _locationController.text.isEmpty ||
                      _date1 == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Please fill in all mandatory fields!')),
                    );
                    return;
                  }
                  if (_date2 != null && _date2!.isBefore(_date1!)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Date 2 must be after Date 1!')),
                    );
                    return;
                  }
                  final newOpportunity = Opportunity(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    location: _locationController.text,
                    date1: _date1!,
                    date2: _date2,
                    image: _selectedImage,
                  );
                  setState(() {
                    opportunities.add(newOpportunity);
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<DateTime?> _selectDate() async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final imageBytes = await pickedImage.readAsBytes();
        setState(() {
          _selectedImage = imageBytes;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image!')),
      );
    }
  }

  void _editOpportunity(int index) {
    Opportunity selectedOpportunity = opportunities[index];
    _titleController.text = selectedOpportunity.title;
    _descriptionController.text = selectedOpportunity.description;
    _locationController.text = selectedOpportunity.location;
    _date1 = selectedOpportunity.date1;
    _date2 = selectedOpportunity.date2;
    _selectedImage = selectedOpportunity.image;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Opportunity'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title *'),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration:
                      InputDecoration(labelText: 'Description (Optional)'),
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(labelText: 'Location *'),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _selectDate().then((pickedDate) {
                          if (pickedDate != null) {
                            setState(() {
                              _date1 = pickedDate;
                            });
                          }
                        });
                      },
                      child: Text('Select Date 1 *'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        _selectDate().then((pickedDate) {
                          if (pickedDate != null) {
                            setState(() {
                              _date2 = pickedDate;
                            });
                          }
                        });
                      },
                      child: Text('Select Date 2 (Optional)'),
                    ),
                  ],
                ),
                if (_selectedImage != null) SizedBox(height: 16),
                if (_selectedImage != null)
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Image.memory(
                      _selectedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Photo'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isEmpty ||
                    _locationController.text.isEmpty ||
                    _date1 == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Please fill in all mandatory fields!')),
                  );
                  return;
                }
                if (_date2 != null && _date2!.isBefore(_date1!)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Date 2 must be after Date 1!')),
                  );
                  return;
                }
                final updatedOpportunity = Opportunity(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  location: _locationController.text,
                  date1: _date1!,
                  date2: _date2,
                  image: _selectedImage,
                );
                setState(() {
                  opportunities[index] = updatedOpportunity;
                });
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _deleteOpportunity(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this opportunity?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  opportunities.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  final List<String> pages = ['Dashboard', 'Users list', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
             
              GoRouter.of(context).pushReplacement('/login');
            },
          ),
        ],
      ),
     
      drawer: HamburgerMenu(
         onUserListTap: () { // Add navigation for User List
          Navigator.pushNamed(context, '/userList');
        },
  onDashboardTap: () {
    // Define the action when the dashboard item is tapped
    Navigator.pop(context); // Close the drawer if needed
    Navigator.pushNamed(context, '/dashboard');
  },
  onProfileTap: () {
    // Define the action when the profile item is tapped
    Navigator.pop(context); // Close the drawer if needed
    Navigator.pushNamed(context, '/profile');
  },

),


      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: ElevatedButton(
              onPressed: _addOpportunity,
              child: Text('Add Opportunity'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: opportunities.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(opportunities[index].title),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    _deleteOpportunity(index);
                  },
                  child: GestureDetector(
                    onTap: () {
                      _editOpportunity(index);
                    },
                    child: OpportunityCard(
                      opportunity: opportunities[index],
                      onEdit: () {
                        _editOpportunity(index);
                      },
                      onDelete: () {
                        _deleteOpportunity(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OpportunityCard extends StatelessWidget {
  final Opportunity opportunity;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const OpportunityCard(
      {Key? key, required this.opportunity, this.onEdit, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: opportunity.image != null
            ? Image.memory(
                opportunity.image!,
                width: 80,
                fit: BoxFit.cover,
              )
            : Container(
                width: 80,
                height: 80,
                color: Colors.grey,
                child: Icon(Icons.image, color: Colors.white),
              ),
        title: Text(opportunity.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(opportunity.description.isNotEmpty
                ? opportunity.description
                : 'No Description'),
            SizedBox(height: 8),
            Text('Location: ${opportunity.location}'),
            SizedBox(height: 8),
            Text(
              'Date 1: ${DateFormat('yyyy-MM-dd').format(opportunity.date1)}\n' +
                  (opportunity.date2 != null
                      ? 'Date 2: ${DateFormat('yyyy-MM-dd').format(opportunity.date2!)}'
                      : 'Date 2: -'),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}

class Opportunity {
  final String title;
  final String description;
  final String location;
  final DateTime date1;
  final DateTime? date2;
  final Uint8List? image;

  Opportunity({
    required this.title,
    required this.description,
    required this.location,
    required this.date1,
    this.date2,
    this.image,
  });
}
