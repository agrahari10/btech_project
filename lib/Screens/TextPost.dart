import 'package:btech_project/repository/Userrepositories.dart';
import 'package:btech_project/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../Provider/PostImage_provider.dart';

class PostTextPage extends StatefulWidget {
  const PostTextPage({ Key? key }) : super(key: key);

  @override
  State<PostTextPage> createState() => _PostTextPageState();
}

class _PostTextPageState extends State<PostTextPage> {
  @override
  Widget build(BuildContext context) {
    UserRepository _auth = Provider.of<UserRepository>(context);
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PostStory(_auth))],
      child: TextPost(),
    );
  }
}

class TextPost extends StatefulWidget {
  const TextPost({ Key? key }) : super(key: key);

  @override
  State<TextPost> createState() => _TextPostState();
}

class _TextPostState extends State<TextPost> {
  String text = "";
   GlobalKey<FormState>? _postText;
   void initState() {
    _postText = GlobalKey<FormState>();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    PostStory _postProvider = context.watch<PostStory>();
    return SafeArea(
      child: Scaffold(
        body:  Column(
          children: [
            Container(
              height: 400,
              child: Center(
                child: SizedBox(
                  width: size.width * 0.85,
                  child: Form(
                    key: _postText,
                    child: CustomTextField(
                      hintText: "Type Story",
                      obscureText: false,
                      onSaved: (_value) {
                        _postProvider.story = _value;
                        
                      },
                      regEx: r"^(?!\s*$).+",
                    ),
                  )),
              ),
            ),
            Container(
              child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.blue,
                            
                          ),
                  onPressed: () {
                    if(_postText!.currentState!.validate()){
                        _postText!.currentState!.save();
                          // ignore: unnecessary_statements
                          _postProvider.postText();

                    }
                    Fluttertoast.showToast(msg: 'Text Post Successfully');
                    Navigator.of(context).pop();
                  },
                  child: Text('Post'),
                ),
            )
          ],
        )
        
      ),
    );
  }
}