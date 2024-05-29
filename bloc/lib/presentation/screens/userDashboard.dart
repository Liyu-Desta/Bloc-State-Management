import 'package:flutter/material.dart';

// void main() {
//   runApp(DashboardApp());
// }

// class DashboardApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Dashboard(),
//     );
//   }
// }

class UserDashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<UserDashboard> {
  List<Opportunity> bookedOpportunities = [
    Opportunity(
      title: 'Volunteers',
      description: 'Description of the volunteers',
      imagePath: 'assets/cartoon.jpeg',
      dates: ['April 05, 2024 morning', 'April 10, 2024 afternoon'],
      selectedDateIndex: 0,
      showDetails: false,
    ),
    // Add more booked opportunities here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 166, 70, 183),
        title: Center(
        child: const Text('User Dashboard'),
    ),
      ),
      body: ListView.builder(
        itemCount: bookedOpportunities.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  setState(() {
                    bookedOpportunities[index].showDetails =
                        !bookedOpportunities[index].showDetails;
                  });
                },
                leading: Image.asset(
                  bookedOpportunities[index].imagePath,
                  fit: BoxFit.cover,
                  width: 100.0,
                  height: 100.0,
                ),
                title: Text(bookedOpportunities[index].title),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showOpportunityDetails(context, bookedOpportunities[index]);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          bookedOpportunities.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (bookedOpportunities[index].showDetails)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookedOpportunities[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(bookedOpportunities[index].description),
                      SizedBox(height: 8.0),
                      DropdownButtonFormField<String>(
                        value: bookedOpportunities[index].dates[bookedOpportunities[index].selectedDateIndex],
                        items: bookedOpportunities[index].dates.map((date) {
                          return DropdownMenuItem<String>(
                            value: date,
                            child: Text(date),
                          );
                        }).toList(),
                        onChanged: (String? newDate) {
                          setState(() {
                            if (newDate != null) {
                              bookedOpportunities[index].selectedDateIndex =
                                  bookedOpportunities[index].dates.indexOf(newDate);
                            }
                          });
                        },
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          _updateOpportunity(bookedOpportunities[index]);
                          setState(() {bookedOpportunities[index].showDetails = false; // Hide description after update
                          });
                        },
                        child: Text('Update'),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _showOpportunityDetails(BuildContext context, Opportunity opportunity) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Volunteer Opportunity'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(opportunity.title, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    Text(opportunity.description),
                    SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      value: opportunity.dates[opportunity.selectedDateIndex],
                      items: opportunity.dates.map((date) {
                        return DropdownMenuItem<String>(
                          value: date,
                          child: Text(date),
                        );
                      }).toList(),
                      onChanged: (String? newDate) {
                        setState(() {
                          if (newDate != null) {
                            opportunity.selectedDateIndex = opportunity.dates.indexOf(newDate);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    _updateOpportunity(opportunity);
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text('Update'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _updateOpportunity(Opportunity opportunity) {
  
    print('Opportunity updated:');
    print('Title: ${opportunity.title}');
    print('Description: ${opportunity.description}');
    print('Selected Date: ${opportunity.dates[opportunity.selectedDateIndex]}');
    print('--------------------------------------');
  }
}

class Opportunity {
  final String title;
  final String description;
  final String imagePath;
  final List<String> dates;
  int selectedDateIndex;
  bool showDetails;

  Opportunity({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.dates,
    this.selectedDateIndex = 0,
    this.showDetails = false,
  });
}