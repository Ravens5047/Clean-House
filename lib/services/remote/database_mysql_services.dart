// import 'package:mysql1/mysql1.dart';

// class MySQLConnection {
//   late MySqlConnection _connection;
//   Future<void> connectToDatabase() async {
//     final settings = ConnectionSettings(
//       host: "127.0.0.1",
//       port: 3306,
//       user: "root",
//       password: "08072002",
//       db: 'clean_house_services',
//     );

//     try {
//       _connection = await MySqlConnection.connect(settings);
//       print('Connected to MySQL database');
//     } catch (e) {
//       print('Error connecting to MySQL database: $e');
//       rethrow;
//     }
//   }

//   Future<void> closeConnection() async {
//     await _connection.close();
//     print('Disconnected from MySQL database');
//   }
// }
