import 'package:campuspro/Modal/student_module/student_remark_model.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget remarkListCardView(StudentRemarkModel remarkData) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w).copyWith(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: AppColors.whitetextcolor,
            border: Border(
              left: BorderSide(color: AppColors.appbuttonColor, width: 2.w),
              top:
                  const BorderSide(color: AppColors.appbuttonColor, width: 0.1),
              bottom:
                  const BorderSide(color: AppColors.appbuttonColor, width: 0.1),
              right:
                  const BorderSide(color: AppColors.appbuttonColor, width: 0.1),
            ),
            borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Given By : ",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600)),
                      TextSpan(
                        text: remarkData.empName ?? "",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.blackcolor,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                      size: 16.sp,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      remarkData.addedOnDate ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 6.h,
            ),
            Wrap(
              spacing: 8.w,
              runSpacing: 4.h,
              alignment: WrapAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border:
                          Border.all(color: AppColors.leavecolor, width: 0.5)),
                  child: Text(
                    remarkData.remark ?? "",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                if (remarkData.extraRemark != null &&
                    remarkData.extraRemark!.isNotEmpty)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: AppColors.leavecolor, width: 0.5)),
                    child: Text(
                      remarkData.extraRemark ?? "",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.blackcolor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
          ],
        ),
      ),
    ],
  );
}
