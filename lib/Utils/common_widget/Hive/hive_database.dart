// import 'dart:io';
// import 'package:hive_flutter/hive_flutter.dart';
//
// class HiveDataBase {
//   static Box<SaveCustomerRegistrationOfflineModel>? customerRegistrationBox;
//   static Box<SaveCustomerRegistrationOfflineModel>? leadBoxCustomerRegistration;
//   static Future<void> init() async {
//     // Directory directory = await getApplicationDocumentsDirectory();
//     // Hive.init(directory.path);
//
//     Directory tempDir = await getApplicationDocumentsDirectory();
//     Directory filesDir = Directory(tempDir.path)..createSync(recursive: true);
//     Hive.init(filesDir.path);
//
//     Hive.registerAdapter<SaveCustomerRegistrationOfflineModel>(SaveCustomerRegistrationOfflineModelAdapter());
//     customerRegistrationBox = await Hive.openBox<SaveCustomerRegistrationOfflineModel>(HiveBoxName.boxNameCustRegi);
//     leadBoxCustomerRegistration = await Hive.openBox<SaveCustomerRegistrationOfflineModel>(HiveBoxName.leadBoxNameCustRegi);
//   }
// }
//
// class HiveTypeId {
//   static const customerRegistrationTypeId = 0;
// }
//
// class HiveBoxName {
//   static get boxNameCustRegi => "CustomerRegistrationData";
//   static get leadBoxNameCustRegi => "AddCustomerRegistrationData";
// }
