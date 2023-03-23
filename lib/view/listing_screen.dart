import 'package:demo/controller/add_data_controller.dart';
import 'package:demo/controller/demo_controller.dart';
import 'package:demo/view/add_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  final demoController = Get.put(DemoController());
  final addDataController = Get.put(AddDataController());

  @override
  void initState() {
    demoController.customInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
        title: const Text(
          "Student Listing",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          addDataController.titleController.value.clear();
          addDataController.descriptionController.value.clear();
          Get.to(
            const AddDataScreen(
              id: 0,
              isEdit: false,
            ),
            transition: Transition.rightToLeft,
          )!
              .whenComplete(() async {
            await demoController.getData();
          });
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: Colors.cyan,
          ),
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () => demoController.dataList.isNotEmpty
            ? ListView.builder(
                itemCount: demoController.dataList.length,
                padding: const EdgeInsets.only(top: 20),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 16, right: 16),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Colors.cyan.withOpacity(0.3),
                            Colors.cyan.withOpacity(0.4),
                            Colors.cyan.withOpacity(0.6),
                            Colors.cyan.withOpacity(0.2),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${demoController.dataList[index]['title']}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${demoController.dataList[index]['description']}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                addDataController.titleController.value.text =
                                    "${demoController.dataList[index]['title']}";
                                addDataController
                                        .descriptionController.value.text =
                                    "${demoController.dataList[index]['description']}";
                                Get.to(
                                  AddDataScreen(
                                    id: demoController.dataList[index]['id'],
                                    isEdit: true,
                                  ),
                                )!
                                    .whenComplete(() async {
                                  await demoController.getData();
                                });
                              },
                              child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.cyan,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            InkWell(
                              onTap: () async {
                                await demoController.deleteData(
                                    demoController.dataList[index]['id']);
                              },
                              child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Center(
                    child: Text(
                      "No any data found",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
