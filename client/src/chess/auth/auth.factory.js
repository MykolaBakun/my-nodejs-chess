module.exports = AuthFactory;

AuthFactory.$inject = ['$https', '$rootScope'];
function AuthFactory($https, $rootScope) {
	return {
    login: login,
    register: register,
    logout: logout
	};

  function login(data) {
    return $https.post(process.env.API_URL + '/login', data, {withCredentials: true}).
    then(function (response) {
      return response.status + ' ' + response.statusText;
    });
  }
  function register(data) {
  	return $https.post(process.env.API_URL + '/register', data, {withCredentials: true}).
  	then(function (response) {
  		return response.status + ' ' + response.statusText;
  	});
  }
  function logout() {
    return $https.post(process.env.API_URL + '/logout', null, {withCredentials: true}).
    then(function (response) {
      $rootScope.$broadcast('userLoggedOut');
      return response.status + ' ' + response.statusText;
    });
  }
};
