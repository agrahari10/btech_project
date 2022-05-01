import 'package:btech_project/Models/Chat_user.dart';
import 'package:btech_project/Provider/UserPage_Provider.dart';
import 'package:btech_project/Services/DatabaseServices.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:btech_project/widgets/CustomList_tile.dart';
import 'package:btech_project/widgets/CustomTextField.dart';
import 'package:btech_project/widgets/Rounded.dart';
import 'package:btech_project/widgets/TopBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late DatabaseServices _databaseServices;
  late User? _authh = FirebaseAuth.instance.currentUser;

  late UserRepository _auth;
  late UsersPageProvider _pageProvider;
  // late String Username;

  final TextEditingController _searchFieldTextEditingController =
      TextEditingController();

  @override
  void initState() {
    _databaseServices = DatabaseServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<UserRepository>(context);
    _databaseServices = GetIt.instance.get<DatabaseServices>();
    // Username = _auth.user as String;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersPageProvider>(
          create: (_) => UsersPageProvider(_auth),
        )
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (BuildContext _context) {
        _pageProvider = _context.watch<UsersPageProvider>();
        return Container(
          color:Color.fromARGB(255, 238, 233, 233),
          padding: EdgeInsets.symmetric(
            vertical: _deviceHeight * 0.02,
            horizontal: _deviceWidth * 0.03,
          ),
          height: _deviceHeight * 0.98,
          width: _deviceWidth * 0.99,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopBar(
                'Users',
              ),
              CustomTextField2(
                  controller: _searchFieldTextEditingController,
                  hintText: "Search...",
                  obscureText: false,
                  onEditingComplete: (_value) {
                    _pageProvider.getUsers(name: _value);
                    FocusScope.of(context).unfocus();
                  }),
              _userList(),
              _createChatButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _userList() {
    List<ChatUser>? _users = _pageProvider.users;
    return Expanded(child: () {
      if (_users != null) {
        if (_users.length != 0) {
          return ListView.builder(
            itemCount: _users.length,
            itemBuilder: (BuildContext _context, int _index) {
              if (_authh?.email != _users[_index].email){
                return CustomListViewTile(
                    height: _deviceHeight * 0.10,
                    imagePath: _users[_index].photoUrl,
                    title: _users[_index].name,
                    isActive: _users[_index].wasRecentlyActive(),
                    isSelected:
                    _pageProvider.selectedUsers.contains(_users[_index]),
                    onTap: () {
                      _pageProvider.updateSelectedUsers(_users[_index]);
                    },
                    subtitle: "Last Active ${_users[_index].lastActiveday()}"
                    );
              }
              return SizedBox();

            },
          );
        } else {
          return Center(
            child: Text(
              "No users found",
              style: TextStyle(color: Colors.black),
            ),
          );
        }

      } else {
        return Center(
          // child: SizedBox(),
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      }
    }());
  }

  Widget _createChatButton() {
    return Visibility(
      visible: _pageProvider.selectedUsers.isNotEmpty,
      child: RoundedButton(
          width: _deviceWidth * 0.80,
          height: _deviceHeight * 0.08,
          // ignore: unrelated_type_equality_checks
          name: _pageProvider.selectedUsers.length == 1
              ? "Chat With ${_pageProvider.selectedUsers.first.name}"
              : "Create Group Chat",
          onPressed: () {
            _pageProvider.createChat();
          }),
    );
  }
}
