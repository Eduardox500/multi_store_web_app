import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_store_web_app/views/side_screens/widgets/category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  static const String screenRoute = "CategoriesScreen";

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  dynamic _image;
  String? _fileName;
  late String _categoryName;
  // el '?' significa que la variable puede ser nula.
  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        _fileName = result.files.first.name;
      });
    }
  }

  _uploadCategoryBannerToFirebaseStorage(dynamic image) async {
    var ref = _firebaseStorage.ref().child('cateforyImages').child(_fileName!);

    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  _uploadCategoryBannerToFireStore() async {
    EasyLoading.show();
    if (_formKey.currentState!.validate()) {
      var imageURL = await _uploadCategoryBannerToFirebaseStorage(_image);
      await _firebaseFirestore.collection('Categories').doc(_fileName).set(
          {'image': imageURL, 'categories': _categoryName}).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _image = null;
        });
      });
    }
    else{

    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Categories Management',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                children: [
                  Container(
                    width: 400,
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: _image != null
                          ? Image.memory(_image)
                          : Text('Upload Category Image'),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Flexible(
                    child: TextFormField(
                      onChanged: (value) {
                        _categoryName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please the Category Name mus not be empty.';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Enter Category Name',
                          hintText: 'Enter Category Name'),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _uploadCategoryBannerToFireStore();
                      },
                      child: Text('Save Category')),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: Text('Select Category Image')),
                  CategoryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
