
// const String baseUrl = "https://esstest.mscorpres.net";  // local Url
// const String baseUrl = "https://essv2.mscorpres.net";  // local Url
// const String baseUrl = "http://192.168.68.110:3005";  // local Url
const String baseUrl = "https://login.mscorpres.online";  // Live Url

const String logInApi = "$baseUrl/login/login";  // Done
const String announcementApi = "$baseUrl/timeline";   // Done
const String birthdayBashApi = "$baseUrl/dashboard/eventBash/DOB"; // Done
const String newHireListApi = "$baseUrl/dashboard/hiresList";   // Done
const String workAnnApi = "$baseUrl/dashboard/eventBash/WA";   //Done
const String earnedLeaveApi = "$baseUrl/dashboard/leave/EL";   //Done
const String leaveListApi = "$baseUrl/dashboard/leave/leavelist";  //Done
const String shiftApi = "$baseUrl/attendance/view/shift";  // Done
const String wfhLeaveApi = "$baseUrl/dashboard/leave/WFH";  // Done
const String sickLeaveApi = "$baseUrl/dashboard/leave/SL";   //Done
const String apiUrlPunch = "$baseUrl/attendance/view/punch/";  // Done
const String apiPeripheral = "$baseUrl/assets";    // Done
const String apiEvents = "$baseUrl/event/?start=&end=";  // done
const String apiLeaveGrant = "$baseUrl/leave/getLeaveList";   //Done
const String apiLeaveStatus = "$baseUrl/leave/getEmpLeaveList";  // Done
const String apiWithdraw = "$baseUrl/leave/LeaveEmpReject";  // Done
const String apiLeaveApprove = "$baseUrl/leave/LeaveApprove";  // Done
const String apiLeaveReject = "$baseUrl/leave/LeaveReject";  // Done
const String apiHolidayEvent = "$baseUrl/event";  // Done
const String apiAttendanceStatistics = "$baseUrl/dashboard/attendance-statistics";  // Done
const String apiCopyMail = "$baseUrl/leave/fetchEMP";  // Done
const String apiPayslip= "$baseUrl/empPayslip/view";  // Done
const String apiProfileView = "$baseUrl/dashboard/profile";  // Done
const String apiSop = "$baseUrl/sop/view";  // Done
const String apiHierarchy = "$baseUrl/hierarchy/orgchart/children/view";  // Done
const String apiDownloadAttendanceReport = "$baseUrl/attendance/download";  // Done

// Apply Leave List
const String apiLeave = "$baseUrl/leave/getBalance";  //Done
const String apiLeaveCalculation = "$baseUrl/leave/getBalance/";
const String apiApplyLeave = "$baseUrl/leave/sendELLeaveRequest";  // Done
const String apiResetPassword = "$baseUrl/login/reset";     // Done


// Leave balance Update
const String apiLeaveUpdateWFH = "$baseUrl/dashboard/updateLeave/WFH";
const String apiLeaveUpdateSL = "$baseUrl/dashboard/updateLeave/SL";
const String apiLeaveUpdateEL = "$baseUrl/dashboard/updateLeave/EL";

