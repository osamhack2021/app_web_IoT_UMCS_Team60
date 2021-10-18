import axios from "axios";

const BASE_URL = "/api/";

function deleteOutsideFacility(id) {
  return axios.delete(`${BASE_URL}outside_facility/${id}`);
}
// Authentication
function signupAdmin(adminData) {
  return axios.post(`${BASE_URL}manager/register`, adminData);
}
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
function fetchOutsideFacilityList() {
  return axios.get(`${BASE_URL}outside_facility`);
}
function fetchRoomInfo(id) {
  return axios.get(`${BASE_URL}doomroom/${id}`);
}
function fetchRoomList_doomId(id) {
  return axios.get(`${BASE_URL}doomroom/search?doom_id=${id}`);
}
function fetchCurrentLocation_Tag(tag) {
  return axios.get(`${BASE_URL}current_position/search?user_tag=${tag}`);
}
function fetchCurrentLocation_BeaconId(beaconId) {
  return axios.get(`${BASE_URL}current_position/search?beacon_id=${beaconId}`);
}

// Monitoring
function createRoomPicker(data) {
  return axios.post(`${BASE_URL}room_picker`, data);
}
function editRoomPicker(data) {
  const pos = {
    x: data.x,
    y: data.y,
  };
  return axios.put(`${BASE_URL}room_picker/${data.id}`, pos);
}
function deleteRoomPicker(id) {
  return axios.delete(`${BASE_URL}room_picker/${id}`);
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
function createSchedule(tableData) {
  return axios.post(`${BASE_URL}timetable`, tableData);
}
function fetchTimeTable(idData) {
  return axios.get(
    `${BASE_URL}timetable/search?doom_id=${idData.doom_id}&facility_id=${idData.facility_id}`
  );
}
function deleteSchedule(id) {
  return axios.delete(`${BASE_URL}timetable/${id}`);
}

// HealthCare
function fetchHealthReport(date) {
  return axios.get(`${BASE_URL}anomaly/search?reported_date=${date}`);
}

// Manage Army
function createFacility(data) {
  return axios.post(`${BASE_URL}doomfacility`, data);
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
  deleteOutsideFacility,
  signupAdmin,
  loginAdmin,
  logoutAdmin,
  fetchCurrentSituation,
  fetchAdmins,
  fetchAdminInfo,
  fetchUsers,
  fetchUserInfo,
  fetchDoomList,
  fetchFacilityList,
  fetchOutsideFacilityList,
  fetchRoomInfo,
  fetchRoomList_doomId,
  fetchCurrentLocation_BeaconId,
  fetchCurrentLocation_Tag,
  createRoomPicker,
  editRoomPicker,
  deleteRoomPicker,
  fetchMovingReport,
  fetchMovingReport_Id,
  fetchUsingReport,
  fetchUsingReport_Id,
  createSchedule,
  fetchTimeTable,
  deleteSchedule,
  fetchHealthReport,
  createFacility,
  fetchAdminDuty_month,
  addDuty,
  deleteDuty,
};
