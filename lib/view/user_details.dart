import 'package:demo/entity/user_model.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key, required this.userRecord});
  final Record userRecord;
  @override
  Widget build(BuildContext context) {
    final res = userRecord;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _userDetails('Nmae', res.name ?? ''),
              const SizedBox(
                height: 10,
              ),
              _userDetails('Email', res.email ?? ''),
              const SizedBox(
                height: 10,
              ),
              _userDetails('Address', res.address?.city ?? ''),
              const SizedBox(
                height: 10,
              ),
              _userDetails('Street', res.address?.street ?? ''),
              const SizedBox(
                height: 10,
              ),
              _userDetails('Suite', res.address?.suite ?? ''),
              const SizedBox(
                height: 10,
              ),
              _userDetails('ZipCode', res.address?.zipcode ?? ''),
              const SizedBox(
                height: 10,
              ),
              _userDetails('Phone', res.phone ?? ''),
              const SizedBox(
                height: 10,
              ),
              _userDetails('WebSite', res.website ?? ''),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userDetails(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(' : $value')
      ],
    );
  }
}
