import 'dart:io';

import 'package:btech_project/Page/profile.dart';
import 'package:btech_project/widgets/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PostImageWithCaption(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Enter Caption for your Story',
                      hintText: ''),
                ),
              ),
              RoundedButton(
                  width: size.width * 0.30,
                  height: size.height * 0.06,
                  name: 'Submit',
                  onPressed: (){
                    Navigator.pop(context);
                  },),
            ],
          ),
        ),
      ),
    );
  }

  Widget PostImageWithCaption() {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              var image = await ImagePicker()
                  .getImage(
                      source: ImageSource.gallery,
                      maxHeight: 600,
                      maxWidth: 600)
                  .then((value) {
                if (mounted)
                  setState(() {
                    print(value?.path);
                    print('&&&&&&&&&&&&&&\n%%%%%%%%%%%%');
                    imageFilePath = value != null ? value.path : '';
                    print(imageFilePath);
                  });
              });
            },
            child: imageFilePath.isEmpty
                ? Container(
                    height: 300,
                    width: 300,
                    child: Icon(Icons.add_a_photo),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(size.width),
                      color: Color(0xffFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 5,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(size.width),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: FileImage(
                          File(imageFilePath),
                        ),
                      ),
                    ),
                  ),
          ),

// )
        ],
      ),
    );
  }
}
