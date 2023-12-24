// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:m_soko/home/products/products_bloc.dart';

Widget advertisementBlock() {
  return FutureBuilder(
    future: fetchAdvertisementsFromFirestore(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        var advertisements = snapshot.data as List<Map<String, dynamic>>;
        return Container(
          height: 135,
          child: PageView.builder(
            itemCount: advertisements.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 135,
                  child: Image.network(
                    advertisements[index]['bannerImage'],
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
        );
      }
    },
  );
}
