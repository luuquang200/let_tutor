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

  // schedule
  static const getNextBookedSchedule = '/booking/next';
}
