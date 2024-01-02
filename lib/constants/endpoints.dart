class Endpoints {
  // Authentication
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const resetPassword = '/user/forgotPassword';

  // Tutor
  static const listTutor = '/tutor/more';
  static const searchTutor = '/tutor/search';
  static const getLearnTopic = '/learn-topic';
  static const getTestPreparation = '/test-preparation';
  static const getTutorDetails = '/tutor';
  static const getCategories = '/category';
  static const manageFavoriteTutor = '/user/manageFavoriteTutor';
  static const getFeedbacks = '/feedback/v2';
  static const reportTutor = '/report';
  static const bookTutor = '/booking';

  static const getSchedule = '/schedule';

  // User
  static const userInformation = '/user/info';
  static const getTotalCall = '/call/total';

  // schedule
  static const getNextBookedSchedule = '/booking/next';
  static const getScheduleList = '/booking/list/student';
  static const cancelSchedule = '/booking/schedule-detail';
}
