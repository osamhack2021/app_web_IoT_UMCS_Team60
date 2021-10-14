import axios from "axios";

const BASE_URL = "/api/";

// Authentication
function loginAdmin(adminData) {
  return axios.post(`${BASE_URL}manager/login`, adminData);
}
function logoutAdmin() {
  return axios.get(`${BASE_URL}manager/logout`);
}

// UserProfile
function fetchUserInfo(tag) {
  return axios.get(`${BASE_URL}user/${tag}`);
}

// Monitoring
function fetchCurrentLocation_Tag(tag) {
  return axios.get(`${BASE_URL}current_position/search?user_tag=${tag}`);
}
function fetchCurrentLocation_BeaconId(beaconId) {
  return axios.get(`${BASE_URL}current_position/search?beacon_id=${beaconId}`);
}

// Moving Report
function fetchMovingReport() {
  return axios.get(`${BASE_URL}outside_request/waiting_permission`);
}

// Using Report
function fetchUsingReport() {
  return axios.get(`${BASE_URL}facility_request/waiting_permission`);
}

// HealthCare
function fetchHealthReport(date) {
  return axios.get(`${BASE_URL}anomaly/search?reported_date=${date}`);
}

export {
  loginAdmin,
  logoutAdmin,
  fetchUserInfo,
  fetchCurrentLocation_BeaconId,
  fetchCurrentLocation_Tag,
  fetchMovingReport,
  fetchUsingReport,
  fetchHealthReport,
};
