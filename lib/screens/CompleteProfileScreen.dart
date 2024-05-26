// import 'package:flutter/material.dart';
//
// import '../../constants.dart';
// import '../components/completeProfile.dart';
//
// class CompleteProfileScreen extends StatelessWidget {
//   static String routeName = "/complete_profile";
//
//   const CompleteProfileScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up'),
//       ),
//       body: SafeArea(
//         child: SizedBox(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 16),
//                   const Text("Complete Profile", style: headingStyle),
//                   const Text(
//                     "Complete your details or continue  \nwith social media",
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   const CompleteProfileForm(),
//                   const SizedBox(height: 30),
//                   Text(
//                     "By continuing your confirm that you agree \nwith our Term and Condition",
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/user_model.dart';
import '../providers/AuthProvider.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  final AuthProvider authProvider;

  CompleteProfileScreen({required this.authProvider, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text("Complete Profile", style: headingStyle),
                  const Text(
                    "Complete your details or continue  \nwith social media",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<UserModel>(
                    future: authProvider.fetchUserDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final user = snapshot.data;
                        return Column(
                          children: <Widget>[
                            Text('Email: ${user?.email}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('Display Name: ${user?.displayName}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('Role: ${user?.role}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('Address: ${user?.address}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('Phone Number: ${user?.phoneNumber}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            if (user?.role == 'vendor') ...[
                              Text('Shop Name: ${user?.shopName}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('Shop Description: ${user?.shopDescription}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('Shop Location: ${user?.shopLocation}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                            // Add more fields as needed
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "By continuing your confirm that you agree \nwith our Term and Condition",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}