import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/auth/register.dart';
import 'package:frontend/notes/get_notes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isButtonDisabled = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    username.addListener(validateInput);
    password.addListener(validateInput);
  }

  void validateInput() {
    setState(() {
      isButtonDisabled =
          !(username.text.isNotEmpty && password.text.isNotEmpty);
    });
  }

  void login() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await Dio().post(
        'http://localhost:3000/login',
        data: {'username': username.text, 'password': password.text},
      );

      if (response.statusCode == 200) {
        await setAccessToken(response.data['access_token']);

        // Navigasi langsung ke halaman GetNotesScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GetNotesScreen()),
        );
      } else {
        showError('Login gagal. Status: ${response.statusCode}');
      }
    } catch (e) {
      showError('Terjadi kesalahan: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> setAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Masuk Akun')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Masuk Notes App',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: TextField(
                controller: username,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: TextField(
                controller: password,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: OutlinedButton(
                onPressed: isButtonDisabled || isLoading ? null : login,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(
                    color:
                        isButtonDisabled || isLoading
                            ? Colors.black12
                            : Colors.black,
                  ),
                ),
                child:
                    isLoading
                        ? const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 12,
                          ),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                        )
                        : Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 12,
                          ),
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              color:
                                  isButtonDisabled
                                      ? Colors.black12
                                      : Colors.black,
                            ),
                          ),
                        ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                  ),
                  child: const Text(
                    'Belum punya akun ?',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistrationScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Daftar',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
