import axios from "axios";

const BASE_URL = "/api/";

// AUthentication
function loginAdmin(adminData) {
  return axios.post(`${BASE_URL}manager/login`, adminData);
}
function logoutAdmin() {
  return axios.get(`${BASE_URL}manager/logout`);
}

// HealthCare.vue
function fetchHealthReport(date) {
  return axios.get(`${BASE_URL}anomaly/search?reported_date=${date}`);
}

export { loginAdmin, logoutAdmin, fetchHealthReport };
