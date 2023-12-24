import 'package:flutter/material.dart';

import '../home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login(context) async {
    try {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/bg-login.jpg",
                  width: 320,
                  height: 229,
                  fit: BoxFit.cover,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 25,
                    bottom: 20,
                  ),
                  child: Text(
                    "Login To Delivery DatFood!",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Text(
                  "Vui lòng đăng nhập để tiếp tục sử dụng từ nhà phát triển...",
                  style: TextStyle(),
                ),
                const SizedBox(height: 20),
                //Username textfield
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                //Password textfield
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: password,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
                //Forgot password
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                ),
                //Login button
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: const Color.fromARGB(255, 243, 114, 63),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        onPressed: () {
                          //call login function here
                          login(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(18),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                //Register button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 243, 114, 63),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 175),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
