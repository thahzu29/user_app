import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_store/resource/theme/app_colors.dart';


void manageHttpResponse({
  required http.Response response, // the HTTP resonse from the request
  required BuildContext context,   // the context is to show snackbar
  required VoidCallback onSuccess, // the callback to excute on a successfull response
}){
  // Switch statement to handle different http status codes
  switch(response.statusCode){
    case 200: // status code 200 indicates a successfull request
    onSuccess();
    break;
    case 400: // status code 400 indicates bad request
    showSnackBar(context, json.decode(response.body)['msg']);
    break;
    case 500: // status code 500 indicates a server error
    showSnackBar(context, json.decode(response.body)['error']);
    break;
    case 201: // status code 201 indicastes a resource was created successfully
    onSuccess();
    break;
  }
}

void showSnackBar(BuildContext context, String title){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: const EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.bluePrimary,
      content: Text(title)));
}