import axios from "axios";

const BASE_URL = "/api/";

// AUthentication
function loginAdmin(adminData) {
  return axios.post(`${BASE_URL}manager/login`, adminData);
}
function logoutAdmin() {
  return axios.get(`${BASE_URL}manager/logout`);
}

// Monitoring
function fetchCurrentPositionInfo(beaconId) {
  return axios.get(`${BASE_URL}current_position/search?beacon_id=${beaconId}`);
}

// HealthCare
function fetchHealthReport(date) {
  return axios.get(`${BASE_URL}anomaly/search?reported_date=${date}`);
}

// UserProfile
function fetchUserProfile(tag) {
  return axios.get(`${BASE_URL}user/${tag}`);
}

export {
  loginAdmin,
  logoutAdmin,
  fetchCurrentPositionInfo,
  fetchHealthReport,
  fetchUserProfile,
};
