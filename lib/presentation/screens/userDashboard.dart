import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:one/Infrastructure/data_providers/userdashboard_api.dart';
import '../../Domain/models/userDashboard_model.dart';

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserDashboard(),
    );
  }
}

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  late Future<List<UserOpportunity>> _userOpportunities;

  @override
  void initState() {
    super.initState();
    _userOpportunities = UserdashboardApi.fetchUserOpportunities();
  }

  void _updateOpportunities() {
    setState(() {
      _userOpportunities = UserdashboardApi.fetchUserOpportunities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 166, 70, 183),
        title: Center(child: const Text('User Dashboard')),
      ),
      body: FutureBuilder<List<UserOpportunity>>(
        future: _userOpportunities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No opportunities found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final opportunity = snapshot.data![index];
                return OpportunityTile(
                  opportunity: opportunity,
                  onUpdate: _updateOpportunities,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class OpportunityTile extends StatefulWidget {
  final UserOpportunity opportunity;
  final VoidCallback onUpdate;

  OpportunityTile({
    required this.opportunity,
    required this.onUpdate,
  });

  @override
  _OpportunityTileState createState() => _OpportunityTileState();
}

class _OpportunityTileState extends State<OpportunityTile> {
  void _showOpportunityDetails(BuildContext context, UserOpportunity opportunity, VoidCallback onUpdate) {
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
                    Text(opportunity.opportunityId.title, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    Text(opportunity.opportunityId.description),
                    SizedBox(height: 8.0),
                    DropdownButtonFormField<int>(
                      value: opportunity.selectedDateIndex,
                      items: [
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Text(opportunity.dates[0].toIso8601String()),
                        ),
                        if (opportunity.opportunityId.date2 != null)
                          DropdownMenuItem<int>(
                            value: 1,
                            child: Text(opportunity.dates[1].toIso8601String()),
                          ),
                      ],
                      onChanged: (int? newIndex) {
                        if (newIndex != null) {
                          setState(() {
                            opportunity.selectedDateIndex = newIndex;
                            opportunity.selectedDate = opportunity.dates[newIndex];
                          });
                        }
                      },
                    ),

                     SizedBox(height: 8.0),
                    Text('Selected Date: ${opportunity.selectedDate.toIso8601String()}'),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    await UserdashboardApi.updateUserOpportunity(opportunity.id, opportunity);
                    Navigator.of(dialogContext).pop();
                    onUpdate();
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

  @override
  Widget build(BuildContext context) {
    final opportunity = widget.opportunity;
    final onUpdate = widget.onUpdate;

    return Column(
      children: [
        ListTile(
          onTap: () {
            _showOpportunityDetails(context, opportunity, onUpdate);
          },
          leading: opportunity.opportunityId.photo.isNotEmpty
              ? Image.memory(
                  Uint8List.fromList(base64Decode(opportunity.opportunityId.photo)),
                  fit: BoxFit.cover,
                  width: 50.0,
                  height: 50.0,
                )
              : null,
          title: Text(opportunity.opportunityId.title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _showOpportunityDetails(context, opportunity, onUpdate);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await UserdashboardApi.deleteUserOpportunity(opportunity.id);
                  onUpdate();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}