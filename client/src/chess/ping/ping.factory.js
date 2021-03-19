module.exports = PingFactory;

PingFactory.$inject = ['$http'];
function PingFactory($http) {
  return {
    get: get,
    post: post,
    setCookie: setCookie
  };

  function get() {
    return $https.get(process.env.API_URL + '/ping').
      then(function (response) {
        return response.data;
      });
  }

  function post() {
    return $https.post(process.env.API_URL + '/ping').
      then(function (response) {
        return response.data;
      });
  }

  function setCookie(name, value) {
    return $https.post(process.env.API_URL + '/ping/cookie', { name: name, value: value }, { withCredentials: true }).
      then(function (response) {
        return response.data;
      });
  }
}
