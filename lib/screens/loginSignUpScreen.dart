import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widget/navigation_menu.dart';
import '../providers/AuthProvider.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({super.key});

  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _shopDescriptionController = TextEditingController();
  final _shopLocationController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;
  String _role = 'user';

  void _toggleFormType() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      _isLoading = true;
    });

    try {
      if (_isLogin) {
        await Provider.of<AuthProvider>(context, listen: false).login(email, password);
        _showSuccessDialog('Login Successful', 'You have successfully logged in.');
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const NavigationMenu()), // add userdata
      );
        //redirect 
      } else {
        final displayName = _displayNameController.text;
        final address = _addressController.text;
        final phoneNumber = _phoneNumberController.text;
        const profilePicture = ''; // Implement profile picture upload functionality if needed
        final role = _role;
        final shopName = role == 'vendor' ? _shopNameController.text : null;
        final shopDescription = role == 'vendor' ? _shopDescriptionController.text : null;
        final shopLocation = role == 'vendor' ? _shopLocationController.text : null;

        await Provider.of<AuthProvider>(context, listen: false).signUp(
          email,
          displayName,
          role,
          profilePicture,
          address,
          phoneNumber,
          password,
          shopName,
          shopDescription,
          shopLocation,
        );
        _showSuccessDialog('Registration Successful', 'You have successfully signed up.');
      }
      // Navigate to the home screen or desired screen on success
    } catch (error) {
      _showErrorDialog('An error occurred!', error.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showSuccessDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
              if (!_isLogin) {
                setState(() {
                  _isLogin = true;
                });
              }
            },
          )
        ],
      ),
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              if (!_isLogin)
                TextFormField(
                  controller: _displayNameController,
                  decoration: const InputDecoration(labelText: 'Display Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a display name';
                    }
                    return null;
                  },
                ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              if (!_isLogin)
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
              if (!_isLogin)
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
              if (!_isLogin)
                DropdownButtonFormField<String>(
                  value: _role,
                  decoration: const InputDecoration(labelText: 'Role'),
                  items: ['user', 'vendor'].map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _role = newValue!;
                    });
                  },
                ),
              if (!_isLogin && _role == 'vendor')
                TextFormField(
                  controller: _shopNameController,
                  decoration: const InputDecoration(labelText: 'Shop Name'),
                  validator: (value) {
                    if (_role == 'vendor' && value!.isEmpty) {
                      return 'Please enter your shop name';
                    }
                    return null;
                  },
                ),
              if (!_isLogin && _role == 'vendor')
                TextFormField(
                  controller: _shopDescriptionController,
                  decoration: const InputDecoration(labelText: 'Shop Description'),
                  validator: (value) {
                    if (_role == 'vendor' && value!.isEmpty) {
                      return 'Please enter your shop description';
                    }
                    return null;
                  },
                ),
              if (!_isLogin && _role == 'vendor')
                TextFormField(
                  controller: _shopLocationController,
                  decoration: const InputDecoration(labelText: 'Shop Location'),
                  validator: (value) {
                    if (_role == 'vendor' && value!.isEmpty) {
                      return 'Please enter your shop location';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 20),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(_isLogin ? 'Login' : 'Sign Up'),
                ),
              TextButton(
                onPressed: _toggleFormType,
                child: Text(
                  _isLogin ? 'Create an account' : 'I already have an account',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
