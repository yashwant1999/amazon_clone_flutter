import 'dart:convert';

import 'package:amazon_clone_tutorial/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess, // Fucntion()?
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, json.decode(response.body)['mag']);
      break;
    case 500:
      showSnackBar(context, json.decode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
