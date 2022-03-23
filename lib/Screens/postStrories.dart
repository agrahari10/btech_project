import 'package:btech_project/Provider/PostImage_provider.dart';
import 'package:btech_project/Services/CloudServices.dart';
import 'package:btech_project/Services/MediaServices.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class PostPage extends StatefulWidget {
  const PostPage({ Key? key }) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  @override
  Widget build(BuildContext context) {
    UserRepository _auth = Provider.of<UserRepository>(context);
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => PostStory(_auth))
    ],
      child: PostAcess(),
    );
  }
}

class PostAcess extends StatefulWidget {
  const PostAcess({ Key? key }) : super(key: key);

  @override
  State<PostAcess> createState() => _PostAcessState();
}

class _PostAcessState extends State<PostAcess> {
  CloudStorageServices? _cloudStorageServices;
  PlatformFile? _profileImage;
  @override
  Widget build(BuildContext context) {
    _cloudStorageServices =
        GetIt.instance.get<CloudStorageServices>();
    PostStory _postProvider = context.watch<PostStory>();
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.red,
            height: 200,
            width: 200,
            child: GestureDetector(onTap: (){
              GetIt.instance.get<MediaServices>().pickImageFromLibrary().then((_file) {
        setState(() {
          _profileImage = _file;
        });
      });
            })),
                  
          
          Container(
          child: Center(child: Container(child: TextButton(onPressed: (){
            print(_profileImage);
            _postProvider.postMessage(_profileImage);
            print('^&'*200);
            Fluttertoast.showToast(msg: 'Image Post Successfully');
            Navigator.of(context).pop();
            // _postProvider.postMessage();
          },child: Text('Submit'),))),
      ),
        ],),
    );
  }
}