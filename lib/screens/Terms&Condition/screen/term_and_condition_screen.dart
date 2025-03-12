import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/common/widget/round_button.dart';
import 'package:ms_ess_portal/screens/dashboard/dashboard_screen.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:ms_ess_portal/style/text_style.dart';

class TermAndConditionScreen extends StatefulWidget {
  const TermAndConditionScreen({super.key});

  @override
  State<TermAndConditionScreen> createState() => _TermAndConditionScreenState();
}

class _TermAndConditionScreenState extends State<TermAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Text("Important - Cyber Alert & Prevention", style: AppTextStyles.kCaption14SemiBoldTextStyle,),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Text(" Cybersecurity Measures",style: AppTextStyles.kSmall12RegularTextStyle,),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                      TextSpan(text: "Avoid downloading Unverified Attachments and Clicking on Unknown Links : ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                      TextSpan(text: "Please be cautious and avoid downloading attachments or clicking on links from unknown or suspicious sources. These can often be disguised as legitimate but may contain malware or lead to phishing websites", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                    ]))
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(text: "Use Strong and Unique Passwords : ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                          TextSpan(text: "Ensure that your passwords are strong, unique, and not easily guessable. A strong password typically includes a mix of upper and lower-case letters, numbers, and special characters. Avoid using the same password across multiple accounts", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                        ]))
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(text: "Regularly Update Your Passwords : ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                          TextSpan(text: "Change your passwords periodically and avoid reusing old passwords. This practice reduces the risk of unauthorized access.", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                        ]))
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(text: "Enable Multi-Factor Authentication (MFA): ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                          TextSpan(text: "Where possible, enable multi-factor authentication for an extra layer of security. MFA requires not just your password but also a second form of verification, making it significantly harder for unauthorized users to gain access.", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                        ]))
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(text: "Be Vigilant and Report Suspicious Activity : ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                          TextSpan(text: "If you notice any unusual activity or receive suspicious emails, report them Immediately to the IT department. Prompt reporting can help prevent potential security breaches.", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                        ]))
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Text(" Why Android Updates are Important ",style: AppTextStyles.kSmall12RegularTextStyle,),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(text: "Security Patches : ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                          TextSpan(text: "These updates address vulnerabilities that hackers can exploit. By installing updates, you significantly reduce the risk of malware infections, ransomware attacks, and data breaches.", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                        ]))
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(text: "Performance Enhancements : ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                          TextSpan(text: "Updates often include optimizations that improve system speed, responsiveness, and overall performance .", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                        ]))
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(text: "Bug Fixes: ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                          TextSpan(text: "Microsoft continually works to identify and fix issues. within Windows Updates resolve these bugs, enhancing system stability,", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                        ]))
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(text: "New Features : ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                          TextSpan(text: "Some updates introduce new features and functionalities, expanding your system's capabilities.", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                        ]))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("In essence, keeping your Windows system up-to-date is essential for protecting your data, ensuring smooth operation, and taking advantage of the latest improvements."
                ,style: AppTextStyles.kSmall10RegularTextStyle,),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(text: "Bug Fixes: ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                          TextSpan(text: "Microsoft continually works to identify and fix issues. within Windows Updates resolve these bugs, enhancing system stability,", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                        ]))
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Text(" Benefits of Windows Backup",style: AppTextStyles.kSmall12RegularTextStyle,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(text: "Data Recovery : ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                          TextSpan(text: "  In case of hardware failure, accidental deletion, or ransomware attacks, a hackup allows you to restore lost files and data", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                        ]))
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(text: "Disaster Recovery : ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                          TextSpan(text: " If your system is compromised or becomes unusable, a backup enables you to restore your system to a previous working state.", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                        ]))
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(text: "Peace of Mind : ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                          TextSpan(text: " Knowing that your important files and data are protected provides significant peace of mind.", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                        ]))
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(text: "Compliance : ", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                          TextSpan(text: " Many industries have data retention and backup requirements that a regular backup helps fulfill.", style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60)),
                        ]))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("By regularly backing up your system, you create a safety net that protects your valuable data and helps you recover from unforeseen. challenges"
                  ,style: AppTextStyles.kSmall10RegularTextStyle,),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("For any queries, our IT team is arranging a training on this topic. Please attend the training in the coming month for a better understanding"
                  ,style: AppTextStyles.kSmall10RegularTextStyle,),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundButton(title: "I read", onTap: (){
                  Get.to(DashboardScreen());
                }),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
