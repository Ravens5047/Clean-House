import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/button/container_circle.dart';
import 'package:capstone2_clean_house/model/services_model.dart';
import 'package:capstone2_clean_house/pages/payment/select_payment.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';

class ServicesNameCleaning extends StatefulWidget {
  const ServicesNameCleaning({
    super.key,
    required this.service,
  });

  final ServicesModel service;

  @override
  State<ServicesNameCleaning> createState() => _ServicesNameCleaningState();
}

class _ServicesNameCleaningState extends State<ServicesNameCleaning> {
  final formKey = GlobalKey<FormState>();
  String? selectedLocation;
  final List<String> locations = [
    'Da Nang',
    'Ha noi',
    'Ho Chi Minh',
    'Hue',
    'Cao Bang',
    'Buon Ma Thuat',
    'Cao Lanh',
    'Da Lat',
  ];

  // Trạng thái lưu trữ số lượng cho mỗi mục
  int bathroomCount = 0;
  int kitchenCount = 0;
  int livingRoomCount = 0;
  int bedroomCount = 0;

  // Hàm tăng số lượng
  void incrementCount(String item) {
    setState(() {
      switch (item) {
        case 'bathroom':
          bathroomCount++;
          break;
        case 'kitchenroom':
          kitchenCount++;
          break;
        case 'livingroom':
          livingRoomCount++;
          break;
        case 'bedroom':
          bedroomCount++;
          break;
      }
    });
  }

  // Hàm giảm số lượng
  void decrementCount(String item) {
    setState(() {
      switch (item) {
        case 'bathroom':
          if (bathroomCount > 0) bathroomCount--;
          break;
        case 'kitchenroom':
          if (kitchenCount > 0) kitchenCount--;
          break;
        case 'livingroom':
          if (livingRoomCount > 0) livingRoomCount--;
          break;
        case 'bedroom':
          if (bedroomCount > 0) bedroomCount--;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            widget.service.name_service ?? '-:-',
            style: const TextStyle(
              color: AppColor.blue,
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Descriptions Service',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColor.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.black.withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(17.0),
                  child: Text(
                    widget.service.description ?? '',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColor.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 55.0,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 74, 180, 241),
                    border: Border.all(
                      width: 1.2,
                      color: AppColor.black.withOpacity(0.98),
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadow,
                        offset: Offset(0.0, 3.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    value: selectedLocation,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppColor.black,
                      size: 30.0,
                    ),
                    elevation: 16,
                    style: const TextStyle(
                      color: AppColor.black,
                      fontSize: 18.0,
                    ),
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLocation = newValue;
                      });
                    },
                    items:
                        locations.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Frequency',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColor.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 80.0,
                    ),
                    ContainerCircle(text: 'Weekly'),
                    const Spacer(),
                    ContainerCircle(text: 'Monthly'),
                    const Spacer(),
                    ContainerCircle(text: 'Bi-Weekly'),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Work Time',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColor.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100.0,
                    ),
                    ContainerCircle(text: '7:00'),
                    const Spacer(),
                    ContainerCircle(text: '10:00'),
                    const Spacer(),
                    ContainerCircle(text: '14:00'),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Bath Room',
                            style: TextStyle(
                              color: AppColor.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              decrementCount('bathroom');
                            },
                          ),
                          Text(
                            bathroomCount.toString(),
                            style: const TextStyle(
                              color: AppColor.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              incrementCount('bathroom');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Kitchen Room',
                            style: TextStyle(
                              color: AppColor.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              decrementCount('kitchenroom');
                            },
                          ),
                          Text(
                            kitchenCount.toString(),
                            style: const TextStyle(
                              color: AppColor.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              incrementCount('kitchenroom');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Living Room',
                            style: TextStyle(
                              color: AppColor.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              decrementCount('livingroom');
                            },
                          ),
                          Text(
                            livingRoomCount.toString(),
                            style: const TextStyle(
                              color: AppColor.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              incrementCount('livingroom');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Bed Room',
                            style: TextStyle(
                              color: AppColor.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              decrementCount('bedroom');
                            },
                          ),
                          Text(
                            bedroomCount.toString(),
                            style: const TextStyle(
                              color: AppColor.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              incrementCount('bedroom');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  child: ContainerCircle.text1(
                    text: 'Total Price \n \t\$100.00',
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                AppElevatedButton.normal1(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const SelectPayment()),
                    );
                  },
                  text: 'Continue',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
