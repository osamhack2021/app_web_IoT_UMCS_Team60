import { fetchRoomInfo, createTimeTable, fetchTimeTable } from "@/api/index.js";

const state = {
  // Facility List
  facilityList: [
    {
      doom_id: 1,
      doom_name: "제1생활관",
      items: [
        {
          floor: 1,
          name: "1층",
          items: [
            {
              beacon_id: "gg:gg:gg:gg:gg:gg",
              doom_id: 1,
              floor: 1,
              name: "1호실",
              total_count: 4,
              current_count: 1,
              doomroom_id: 1,
            },
            {
              beacon_id: "hh:hh:hh:hh:hh:hh",
              doom_id: 1,
              floor: 1,
              name: "2호실",
              total_count: 2,
              current_count: 0,
              doomroom_id: 2,
            },
            {
              beacon_id: "ii:ii:ii:ii:ii:ii:ii",
              doom_id: 1,
              floor: 1,
              name: "3호실",
              total_count: 4,
              current_count: 0,
              doomroom_id: 3,
            },
            {
              beacon_id: "jj:jj:jj:jj:jj:jj",
              doom_id: 1,
              floor: 1,
              name: "4호실",
              total_count: 10,
              current_count: 0,
              doomroom_id: 4,
            },
            {
              beacon_id: "kk:kk:kk:kk:kk:kk",
              doom_id: 1,
              floor: 1,
              name: "5호실",
              total_count: 1,
              current_count: 0,
              doomroom_id: 5,
            },
            {
              name: "세탁실",
              beacon_id: "pp:pp:pp:pp:pp:pp",
              doom_id: 1,
              floor: 1,
              current_count: 2,
              doomfacility_id: 1,
            },
            {
              name: "1층 화장실",
              beacon_id: "qq:qq:qq:qq:qq:qq",
              doom_id: 1,
              floor: 1,
              current_count: 0,
              doomfacility_id: 2,
            },
            {
              name: "1층 세면장",
              beacon_id: "rr:rr:rr:rr:rr:rr",
              doom_id: 1,
              floor: 1,
              current_count: 0,
              doomfacility_id: 3,
            },
            {
              name: "1층 샤워실",
              beacon_id: "ss:ss:ss:ss:ss:ss",
              doom_id: 1,
              floor: 1,
              current_count: 0,
              doomfacility_id: 4,
            },
          ],
        },
        {
          floor: 2,
          name: "2층",
          items: [
            {
              beacon_id: "ll:ll:ll:ll:ll:ll",
              doom_id: 1,
              floor: 2,
              name: "6호실",
              total_count: 6,
              current_count: 0,
              doomroom_id: 6,
            },
            {
              beacon_id: "mm:mm:mm:mm:mm:mm",
              doom_id: 1,
              floor: 2,
              name: "7호실",
              total_count: 4,
              current_count: 0,
              doomroom_id: 7,
            },
            {
              beacon_id: "nn:nn:nn:nn:nn:nn",
              doom_id: 1,
              floor: 2,
              name: "8호실",
              total_count: 8,
              current_count: 0,
              doomroom_id: 8,
            },
            {
              beacon_id: "oo:oo:oo:oo:oo:oo",
              doom_id: 1,
              floor: 2,
              name: "9호실",
              total_count: 7,
              current_count: 0,
              doomroom_id: 9,
            },
            {
              name: "2층 화장실",
              beacon_id: "tt:tt:tt:tt:tt:tt",
              doom_id: 1,
              floor: 2,
              current_count: 0,
              doomfacility_id: 5,
            },
            {
              name: "2층 세면장",
              beacon_id: "uu:uu:uu:uu:uu:uu",
              doom_id: 1,
              floor: 2,
              current_count: 0,
              doomfacility_id: 6,
            },
            {
              name: "2층 샤워실",
              beacon_id: "vv:vv:vv:vv:vv:vv",
              doom_id: 1,
              floor: 2,
              current_count: 0,
              doomfacility_id: 7,
            },
          ],
        },
      ],
    },
  ],

  /* Data Table */
  // Loading
  loading: false,

  selectedFacility: "공용 시설",

  tableHeaders: [
    { text: "호실/생활관", value: "room" },
    { text: "시작 시각", value: "startTime" },
    { text: "종료 시각", value: "endTime" },
    { text: "수정 / 삭제", value: "actions", sortable: false },
  ],
  tableDatas: [],
};

const getters = {
  getLoading(state) {
    return state.loading;
  },
};

const mutations = {
  // Facility List
  setSelectedFacility(state, value) {
    state.selectedFacility = value;
  },

  setLoading(state, value) {
    state.loading = value;
  },

  // Time Table
  updateTimeTable(state, data) {
    state.tableDatas = data;
  },
};

const actions = {
  async FETCH_TIME_TABLE({ commit }, idData) {
    commit("setLoading", true);
    try {
      const response = await fetchTimeTable(idData);
      const resData = response.data.data;
      const data = [];
      if (resData) {
        resData.forEach(async (elem) => {
          const obj = {};
          const roomInfo = await fetchRoomInfo(elem.room_id);
          const startTime = new Date(elem.start_time);
          const endTime = new Date(elem.end_time);
          const option = { hour: "2-digit", minute: "2-digit", hour12: false };

          obj.room = roomInfo.data.data.name;
          obj.startTime = startTime.toLocaleTimeString([], option);
          obj.endTime = endTime.toLocaleTimeString([], option);
          data.push(obj);
        });
      } else {
        console.log("이용 시간표 정보가 없습니다!");
      }
      commit("updateTimeTable", data);
      commit("setLoading", false);
      return data;
    } catch (error) {
      console.log(error);
    }
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
