import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/models/new_model.dart';

class NewDetailScreen extends StatelessWidget {
  const NewDetailScreen({super.key, required this.newModel});
  final NewModel newModel;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(250),
            child: Container(
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 250,
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black, width: 1),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    newModel.new_img,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            )),
        bottomSheet: Container(
          height: size.height / 1.1,
          width: size.width,
          decoration: BoxDecoration(
            color: Color.fromARGB(223, 248, 249, 251),
            borderRadius: BorderRadius.circular(34),
          ),
          child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      newModel.new_title,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(newModel.new_subtitle,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(newModel.new_content, style: TextStyle(fontSize: 18)),
                ],
              )),
        ));
  }
}
