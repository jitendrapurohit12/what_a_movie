class DBConstants{

  static String baseUrl = 'http://159.65.95.5:3000';

  static get allMovies => '$baseUrl/api/movies';
  static String favourites(int uid) => '$baseUrl/api/users/$uid/movies';
  static String getUser(String username) => '$baseUrl/api/users?username=$username';
  static String getUserRegistration() => '$baseUrl/api/users';
  static String addToFavourite(int uid, int movieId) => '$baseUrl/api/users/$uid/movies/$movieId/favorite';
  static String removeFromFavourite(int uid, int movieId) => '$baseUrl/api/users/$uid/movies/$movieId/unfavorite';
}