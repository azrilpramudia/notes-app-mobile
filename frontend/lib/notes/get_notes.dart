import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class GetNotesScreen extends StatefulWidget {
  const GetNotesScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _GetNotesScreenState createState() => _GetNotesScreenState();
}

class _GetNotesScreenState extends State<GetNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Center(
            heightFactor: 2,
            child: FractionallySizedBox(
              widthFactor: 0.75,
              child: ElevatedButton(
                onPressed: () {
                  null;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  child: Text(
                    'Buat catatan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const FractionallySizedBox(
            widthFactor: 0.75,
            child: Text(
              'Daftar Catatan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
