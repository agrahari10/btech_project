import 'dart:io';

import 'package:btech_project/Provider/PostImage_provider.dart';
import 'package:btech_project/Services/CloudServices.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    UserRepository _auth = Provider.of<UserRepository>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostStory(_auth))
        ],
      child: PostAcess(),
    );
  }
}

class PostAcess extends StatefulWidget {
  const PostAcess({Key? key}) : super(key: key);

  @override
  State<PostAcess> createState() => _PostAcessState();
}

class _PostAcessState extends State<PostAcess> {
  PickedFile? imageFile;
  @override
  Widget build(BuildContext context) {
    PostStory _postProvider = context.watch<PostStory>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Container(
                  height: 450,
                  width: 500,
                  child: GestureDetector(
                      onTap: () async {
                        var pickedFile = await ImagePicker().getImage(
                            source: ImageSource.gallery, imageQuality: 25);
                        setState(() {
                          imageFile = pickedFile!;
                        });
                      },
                      child: imageFile != null
                          ? Container(
                              child: Image.file(
                                File(imageFile!.path),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                          : Container(
                              color: Colors.grey[100],
                            ))),
            ),
            Container(
              child: Center(
                  child: Container(
                      child: 
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                          
                        ),
                onPressed: () {
                  _postProvider.postMessage(imageFile);
                  print('^&' * 200);
                  print(imageFile);
                  Fluttertoast.showToast(msg: 'Image Post Successfully');
                  Navigator.of(context).pop();
                },
                child: Text('Post'),
              ),)),
            ),
          ],
        ),
      ),
    );
  }
}
