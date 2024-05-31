import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one/presentation/Events/menu_opportunity_event.dart';
import 'package:one/presentation/State/menu_opportunity_state.dart';
import 'package:one/Domain/models/menu_opportunity_model.dart';
import 'package:one/Application/bloc/menu_opportunity_bloc.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late MenuOpportunityBloc _menuOpportunityBloc;

  @override
  void initState() {
    super.initState();
    _menuOpportunityBloc = BlocProvider.of<MenuOpportunityBloc>(context);
    _menuOpportunityBloc.add(FetchOpportunity());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Opportunities For You'),
      ),
      body: BlocBuilder<MenuOpportunityBloc, MenuOpportunityState>(
        builder: (context, state) {
          if (state is MenuOpportunityLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MenuOpportunityFailure) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is MenuOpportunitySuccess) {
            if (state.menuOpportunities.isEmpty) {
              return Center(child: Text('No opportunities available'));
            } else {
              return ListView.builder(
                itemCount: state.menuOpportunities.length,
                itemBuilder: (context, index) {
                  return buildMenuItemWidget(context, state.menuOpportunities[index]);
                },
              );
            }
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Widget buildMenuItemWidget(BuildContext context, MenuOpportunity menuOpportunity) {
    return GestureDetector(
      onTap: () {
        _showOpportunityDetails(context, menuOpportunity);
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: menuOpportunity.image != null
                ? Image.memory(
                    menuOpportunity.image!,
                    fit: BoxFit.cover,
                    height: 100.0,
                    width: 100.0,
                  )
                : Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey,
                    child: Icon(Icons.image, color: Colors.white),
                  ),
        ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    menuOpportunity.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    menuOpportunity.description.isNotEmpty
                        ? menuOpportunity.description
                        : 'No Description',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _registerOpportunity(context, menuOpportunity);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  void _showOpportunityDetails(BuildContext context, MenuOpportunity menuOpportunity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                menuOpportunity.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Description: ${menuOpportunity.description}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Location: ${menuOpportunity.location}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Date: ${menuOpportunity.date1}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _registerOpportunity(context, menuOpportunity);
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Register'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _registerOpportunity(BuildContext context, MenuOpportunity menuOpportunity) {
    _menuOpportunityBloc.add(RegisterOpportunity(menuOpportunity: menuOpportunity));
  }
}
