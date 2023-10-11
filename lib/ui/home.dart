import 'package:flutter/material.dart';
import '../api/apiservice.dart';
import '../model/model.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  BankHoliday? bankHolidayData;

  // Fetch Weather data using ApiService
  void fetchData() async {
    ApiService apiService = ApiService();
    BankHoliday bank = await apiService.getUserDetails();

    setState(() {
      bankHolidayData = bank;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Data'),
      ),
      body: Center(
        child: bankHolidayData == null
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: bankHolidayData!.englandAndWales.events.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(bankHolidayData!.englandAndWales.events[index].title),
                  );
                },
              ),
      ),
    );
  }
}
