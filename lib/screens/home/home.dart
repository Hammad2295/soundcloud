import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:souncloud_clone/models/song.dart';
import 'package:souncloud_clone/models/user.dart';
import 'package:souncloud_clone/screens/home/widget/music_list.dart';
import 'package:souncloud_clone/services/auth.dart';
import 'package:souncloud_clone/services/database_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: MainBody()),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({
    super.key,
  });

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  final AuthencationService _authService = AuthencationService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserRecord>(
      stream: DatabaseService().userRecord,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // UserRecord record = snapshot.data!;
          return StreamProvider<List<Song>>.value(
            value: DatabaseService().songs,
            initialData: [],
            catchError: (context, error) => [],
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await _authService.signOut();
                        },
                        icon: const Icon(
                          Icons.logout_rounded,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: const MusicView()),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: SpinKitCircle(
                color: Colors.blue,
                size: 50,
              ),
            ),
          );
        }
      },
    );
  }
}
