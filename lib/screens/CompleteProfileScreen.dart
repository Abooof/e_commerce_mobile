import 'package:e_commerce_mobile/Widget/homeAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/user_model.dart';
import '../providers/AuthProvider.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  const CompleteProfileScreen( {super.key});


  @override
  Widget build(BuildContext context) {
        final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profile'),
      //   backgroundColor: Colors.deepPurple,
      // ),
      appBar: THomeAppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    ' Your Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<UserModel>(
                    future: authProvider.fetchUserDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        );
                      } else {
                        final user = snapshot.data;
                        return Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _buildProfileField('Email', user?.email),
                                _buildProfileField('Display Name', user?.displayName),
                                _buildProfileField('Role', user?.role),
                                _buildProfileField('Address', user?.address),
                                _buildProfileField('Phone Number', user?.phoneNumber),
                                if (user?.role == 'vendor') ...[
                                  Divider(),
                                  _buildProfileField('Shop Name', user?.shopName),
                                  _buildProfileField('Shop Description', user?.shopDescription),
                                  _buildProfileField('Shop Location', user?.shopLocation),
                                ],
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'Not available',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
