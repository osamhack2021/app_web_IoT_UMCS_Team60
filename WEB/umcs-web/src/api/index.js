import axios from "axios";

const BASE_URL = "/api/";

// Authentication
function loginAdmin(adminData) {
  return axios.post(`${BASE_URL}manager/login`, adminData);
}
function logoutAdmin() {
  return axios.get(`${BASE_URL}manager/logout`);
}

// Common
function fetchCurrentSituation() {
  return axios.get(`${BASE_URL}cohort_status/now`);
}
function fetchAdmins() {
  return axios.get(`${BASE_URL}manager`);
}
function fetchAdminInfo(tag) {
  return axios.get(`${BASE_URL}manager/${tag}`);
}
function fetchUsers() {
  return axios.get(`${BASE_URL}user`);
}
function fetchUserInfo(tag) {
  return axios.get(`${BASE_URL}user/${tag}`);
}
function fetchDoomList() {
  return axios.get(`${BASE_URL}doom`);
}
function fetchFacilityList() {
  return axios.get(`${BASE_URL}watchman/myCharge/details`);
}
function fetchRoomInfo(id) {
  return axios.get(`${BASE_URL}doomroom/${id}`);
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
function fetchMovingReport_Id(id) {
  return axios.get(`${BASE_URL}outside_request/${id}`);
}

// Using Report
function fetchUsingReport() {
  return axios.get(`${BASE_URL}facility_request/waiting_permission`);
}
function fetchUsingReport_Id(id) {
  return axios.get(`${BASE_URL}facility_request/${id}`);
}

// Facility Time Schedule
function createTimeTable(tableData) {
  return axios.post(`${BASE_URL}timetable`, tableData);
}
function fetchTimeTable(idData) {
  return axios.get(
    `${BASE_URL}timetable/search?doom_id=${idData.doom_id}&facility_id=${idData.facility_id}`
  );
}

// HealthCare
function fetchHealthReport(date) {
  return axios.get(`${BASE_URL}anomaly/search?reported_date=${date}`);
}

// Manage Admin
function fetchAdminDuty_month(dateString) {
  const date = new Date(dateString);
  const year = date.getFullYear();
  const month = date.getMonth()+1;
  return axios.get(`${BASE_URL}watchman/search?year=${year}&month=${month}`);
}
function addDuty(data) {
  const obj = {
    manager_tags: data.admin,
    charge_doom: data.doom,
    responsible_date: data.date,
  };
  console.log("obj", obj);
  return axios.post(`${BASE_URL}watchman`, obj);
}
function deleteDuty(id) {
  return axios.delete(`${BASE_URL}watchman/${id}`);
}

export {
  loginAdmin,
  logoutAdmin,
  fetchCurrentSituation,
  fetchAdmins,
  fetchAdminInfo,
  fetchUsers,
  fetchUserInfo,
  fetchDoomList,
  fetchFacilityList,
  fetchRoomInfo,
  fetchCurrentLocation_BeaconId,
  fetchCurrentLocation_Tag,
  fetchMovingReport,
  fetchMovingReport_Id,
  fetchUsingReport,
  fetchUsingReport_Id,
  createTimeTable,
  fetchTimeTable,
  fetchHealthReport,
  fetchAdminDuty_month,
  addDuty,
  deleteDuty,
};
