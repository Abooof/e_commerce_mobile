// import 'package:flutter/material.dart';
//
// // import 'package:e_commerce_mobile/lib/components/icon.dart';
// import '../../../components/form_error.dart';
// import '../../../constants.dart';
// import 'icon.dart';
// // import '../../otp/otp_screen.dart';
//
// class CompleteProfileForm extends StatefulWidget {
//   const CompleteProfileForm({super.key});
//
//   @override
//   _CompleteProfileFormState createState() => _CompleteProfileFormState();
// }
//
// class _CompleteProfileFormState extends State<CompleteProfileForm> {
//   final _formKey = GlobalKey<FormState>();
//   final List<String?> errors = [];
//   String? firstName;
//   String? lastName;
//   String? phoneNumber;
//   String? address;
//
//   void addError({String? error}) {
//     if (!errors.contains(error)) {
//       setState(() {
//         errors.add(error);
//       });
//     }
//   }
//
//   void removeError({String? error}) {
//     if (errors.contains(error)) {
//       setState(() {
//         errors.remove(error);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             onSaved: (newValue) => firstName = newValue,
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 removeError(error: kNamelNullError);
//               }
//               return;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 addError(error: kNamelNullError);
//                 return "";
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               labelText: "First Name",
//               hintText: "Enter your first name",
//               // If  you are using latest version of flutter then lable text and hint text shown like this
//               // if you r using flutter less then 1.20.* then maybe this is not working properly
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             onSaved: (newValue) => lastName = newValue,
//             decoration: const InputDecoration(
//               labelText: "Last Name",
//               hintText: "Enter your last name",
//               // If  you are using latest version of flutter then lable text and hint text shown like this
//               // if you r using flutter less then 1.20.* then maybe this is not working properly
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             keyboardType: TextInputType.phone,
//             onSaved: (newValue) => phoneNumber = newValue,
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 removeError(error: kPhoneNumberNullError);
//               }
//               return;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 addError(error: kPhoneNumberNullError);
//                 return "";
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               labelText: "Phone Number",
//               hintText: "Enter your phone number",
//               // If  you are using latest version of flutter then lable text and hint text shown like this
//               // if you r using flutter less then 1.20.* then maybe this is not working properly
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             onSaved: (newValue) => address = newValue,
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 removeError(error: kAddressNullError);
//               }
//               return;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 addError(error: kAddressNullError);
//                 return "";
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               labelText: "Address",
//               hintText: "Enter your address",
//               // If  you are using latest version of flutter then lable text and hint text shown like this
//               // if you r using flutter less then 1.20.* then maybe this is not working properly
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               suffixIcon:
//               CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
//             ),
//           ),
//           FormError(errors: errors),
//           const SizedBox(height: 20),
//           // ElevatedButton(
//           //   onPressed: () {
//           //     if (_formKey.currentState!.validate()) {
//           //       Navigator.pushNamed(context, OtpScreen.routeName);
//           //     }
//           //   },
//           //   child: const Text("Continue"),
//           // ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

class CompleteProfileForm extends StatelessWidget {
  const CompleteProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return FutureBuilder<Map<String, dynamic>>(
      future: authProvider.getCurrentUserDetails(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('An error occurred!'));
        } else {
          final userDetails = snapshot.data!;
          return Column(
            children: [
              ListTile(
                title: const Text('First Name'),
                subtitle: Text(userDetails['firstName']),
              ),
              ListTile(
                title: const Text('Last Name'),
                subtitle: Text(userDetails['lastName']),
              ),
              ListTile(
                title: const Text('Phone Number'),
                subtitle: Text(userDetails['phoneNumber']),
              ),
              ListTile(
                title: const Text('Address'),
                subtitle: Text(userDetails['address']),
              ),
            ],
          );
        }
      },
    );
  }
}