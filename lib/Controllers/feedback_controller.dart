import 'dart:developer';
import 'package:campuspro/Repository/StudentRepositories/feedback_repo.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Modal/feedback_model.dart';

class StudentFeedbackController extends GetxController {
  // Variables to hold the feedback data
  var type = 'Complain'.obs;
  final RxString topic = ''.obs;
  final RxString subject = ''.obs;
  final RxString detail = ''.obs;
  final RxString topicError = ''.obs;
  final RxString subjectError = ''.obs;
  final RxString messageError = ''.obs;

  RxBool showerror = false.obs;
  RxBool globalError = false.obs;
  RxBool sendLoader = false.obs;

  TextEditingController typeController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  final FocusNode topicNode = FocusNode();
  final FocusNode subjectNode = FocusNode();
  final FocusNode detailNode = FocusNode();

  var isTopicFocus = false.obs;
  var isSubjectFocus = false.obs;
  var isDetailFocus = false.obs;

  @override
  void onInit() {
    super.onInit();
    topicNode.addListener(() {
      isTopicFocus.value = topicNode.hasFocus;
    });
    subjectNode.addListener(() {
      isSubjectFocus.value = subjectNode.hasFocus;
    });
    detailNode.addListener(() {
      isDetailFocus.value = detailNode.hasFocus;
    });
  }

  void validateTopic(BuildContext context) async {
    bool isValid = true;

    // Validate Topic
    if (topic.value.isEmpty) {
      topicError.value = "Please enter Topic";
      isValid = false;
    } else {
      topicError.value = "";
    }

    // Validate Subject
    if (subject.value.isEmpty) {
      subjectError.value = "Please enter Subject";
      isValid = false;
    } else {
      subjectError.value = "";
    }

    // Validate Message
    if (detail.value.isEmpty) {
      messageError.value = "Please enter Message";
      isValid = false;
    } else {
      messageError.value = "";
    }

    if (isValid) {
      await submitFeedback();
    } else {
      showerror.value = true;
    }
  }

  // studentFeedbackData({required String flag}) {}

  // }
  Future<void> submitFeedback() async {
    sendLoader.value = true; // Start loading indicator

    try {
      await studentFeedbackData(flag: "Save");

      CommonFunctions.showSuccessSnackbar(
          "Success", "Feedback submitted successfully");

      clearFeedbackFields();
    } catch (e) {
      log("Error while submitting feedback: ${e.toString()}");
      CommonFunctions.showErrorSnackbar(
          "Error", "An error occurred while submitting feedback");
    } finally {
      sendLoader.value = false; // Stop loading indicator
    }
  }

  Future<List<FeedbackModel>> studentFeedbackData(
      {required String flag}) async {
    sendLoader.value = true;

    try {
      final response = await StudentfeedbackRepo.getfeedback(flag: flag);

      if (response != null && response['Status'] == "Cam-001") {
        List<dynamic> listdata = response['Data'];

        if (flag == "Get") {
          FeedbackM.feedbackList =
              listdata.map((json) => FeedbackModel.fromJson(json)).toList();
          return FeedbackM.feedbackList;
        } else {
          studentFeedbackData(flag: "Get");
          return [];
        }
      } else if (response != null && response['Status'] == "Cam-006") {
        return [];
      } else {
        CommonFunctions.showErrorSnackbar("Error", "Failed to load data");
        return [];
      }
    } catch (e) {
      log(e.toString());
      CommonFunctions.showErrorSnackbar(
          "Error", "An unexpected error occurred");
      return [];
    } finally {
      sendLoader.value = false;
    }
  }

  void clearFeedbackFields() {
    // Clear all the TextEditingControllers and feedback data
    topicController.clear();
    subjectController.clear();
    detailController.clear();
    type.value = 'Complain'; // Reset the type

    // Clear the RxString values
    topic.value = '';
    subject.value = '';
    detail.value = '';

    // Clear any error messages
    topicError.value = '';
    subjectError.value = '';
    messageError.value = '';

    // Reset the focus
    showerror.value = false;
  }
}
