<template>
  <div>
    <v-snackbar
      v-model="editMode"
      color="#ff5252"
      :timeout="-1"
      class="mb-8"
    >
      <v-alert
        type="error"
        prominent
        dense
        class="pa-0 mx-4 my-0"
      >
        <v-row align="center">
          <v-col class="grow font-weight-medium">
            Room Icon의 편집(위치 이동)은 한번에 하나만 가능합니다
          </v-col>
        </v-row>
      </v-alert>
    </v-snackbar>
    <v-row>
      <v-col
        cols="12"
        xl="8"
        class="mx-auto"
      >
        <v-row>
          <v-col cols="8">
            <div
              v-for="doom in facilityList"
              :key="doom.doom_id"
            >
              <v-card class="mt-5">
                <v-card-actions>
                  <v-row>
                    <v-spacer />
                    <v-col cols="3">
                      <v-btn
                        block
                        @click="test"
                      >
                        추가
                      </v-btn>
                    </v-col>
                    <v-spacer />
                    <v-col cols="3">
                      <!-- Edit Mode Changer -->
                      <v-btn
                        block
                        @click="editModeChanged"
                      >
                        {{ getEditText }}
                      </v-btn>
                    </v-col>
                    <v-spacer />
                  </v-row>
                <!-- Dialog for Create Icon -->
                <!-- <v-dialog v-model="dialog" width="600">
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn
                        v-bind="attrs"
                        v-on="on"
                      >
                        추가
                      </v-btn>
                    </template>
                    <v-card class="pa-3">
                      <v-card-title>
                        <span class="text-h5">관리자 등록</span>
                      </v-card-title>
                      <v-card-text>
                        <v-container>
                          <v-row>
                            Select Manage Doom
                            <v-col cols="12" sm="6">
                              <v-select
                                v-model="doomSelected"
                                :items="facilityList"
                                label="시설 선택"
                                item-text="doom_name"
                                prepend-icon="mdi-home-city"
                                required
                              >
                                <template v-slot:selection="data">
                                  {{ data.item.doom_name }}
                                </template>
                                <template v-slot:item="data">
                                  <v-list-item-content
                                    v-text="data.item.doom_name"
                                  />
                                </template>
                              </v-select>
                            </v-col>
                          </v-row>
                        </v-container>
                      </v-card-text>
                      <v-card-actions>
                        <v-spacer />
                        <v-btn
                          color="blue darken-1"
                          text
                          class="text-body-1 font-weight-medium"
                          @click="closeDialog"
                        >
                          닫기
                        </v-btn>
                        <v-btn
                          color="blue darken-1"
                          text
                          class="text-body-1 font-weight-medium"
                          @click="submitForm"
                        >
                          저장
                        </v-btn>
                      </v-card-actions>
                    </v-card>
                  </v-dialog> -->
                </v-card-actions>
                <!-- v-for 사용하여 나열 -->
                <v-card
                  v-for="floor in doom.items"
                  :key="floor.floor"
                  outlined
                >
                  <!-- Toolbar -->
                  <v-card-title class="py-2">
                    {{ floor.name }}
                  </v-card-title>

                  <v-img
                    :src="
                      require(`@/assets/doom${doom.doom_id}-floor${floor.floor}-drawing.png`)
                    "
                  >
                    <template v-for="picker in floor.items">
                      <vue-draggable-resizable
                        v-if="picker.room_picker"
                        :key="picker.beacon_id"
                        :w="50"
                        :h="50"
                        :x="picker.room_picker.x"
                        :y="picker.room_picker.y"
                        :draggable="editMode"
                        :resizable="false"
                        class-name="box-content"
                        @dragging="onDrag"
                      >
                        <v-btn
                          fab
                          small
                          class="info text-body-1 font-weight-medium white--text"
                          @click="
                            pickerClicked(
                              picker.name,
                              picker.beacon_id,
                              picker.room_picker.id
                            )
                          "
                        >
                          {{ picker.current_count }}
                        </v-btn>
                      </vue-draggable-resizable>
                    </template>
                  </v-img>
                </v-card>
              </v-card>
            </div>
          </v-col>

          <!-- People list -->
          <v-col
            cols="4"
            class="mt-5"
          >
            <v-card>
              <v-card-title>
                <span>{{ focusRoom }} 인원현황</span>
                <v-spacer />
                <v-icon
                  v-if="focusPickerId"
                  @click="deleteRoomIcon"
                >
                  mdi-delete
                </v-icon>
              </v-card-title>
              <v-card-text>
                <!-- Search Bar -->
                <v-text-field
                  v-model="searchInput"
                  append-icon="mdi-magnify"
                  label="Search"
                  single-line
                  hide-details
                  clearable
                />
              </v-card-text>
              <v-data-table
                :headers="tableHeaders"
                :items="tableDatas"
                :search="searchInput"
                :loading="isLoading"
                hide-default-footer
                :items-per-page="$store.state.ITEMS_PER_PAGE"
                :page.sync="page"
                class="elavation-1"
              >
                <!-- Slot:item.name - user profile routing -->
                <template v-slot:[`item.name`]="{ item }">
                  <router-link
                    :to="`/user/${item.tag}`"
                    class="info--text text-decoration-none"
                  >
                    {{ item.name }}
                  </router-link>
                </template>
              </v-data-table>
              <!-- Pagination -->
              <div class="text-center pt-2">
                <v-pagination
                  v-model="page"
                  :length="pageCount"
                  :total-visible="$store.state.TOTAL_VISIBLE"
                />
              </div>
            </v-card>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </div>
</template>

<script>
/* Note */
/* 화면 띄우는 Logic */
// 건물과 층까지의 data를 받아온다 → (건물이 1개라면) 각 층에 해당하는 건물 도면이 담긴 card를 띄운다
// → 각 층에 해당하는 icon element에 대한 data를 서버로부터 받아와서 띄운다
// → (클릭할 경우) beacon_id를 확인하여 해당 시설에 있는 사람들의 정보를 띄운다

import { mapState, mapGetters, mapMutations, mapActions } from "vuex";
import VueDraggableResizable from "vue-draggable-resizable";

export default {
  name: "Monitoring",
  components: {
    VueDraggableResizable,
  },
  data() {
    return {
      page: 1,
      dialog: false,
      doomSelected: "",
      floorSelected: "",
      placeSelected: "",
    };
  },
  computed: {
    ...mapState(["facilityList"]),
    ...mapState("doom_monitoring", [
      "editMode",
      "focusPickerId",
      "focusRoom",
      "tableHeaders",
      "tableDatas",
    ]),
    ...mapGetters("doom_monitoring", [
      "getEditText",
      "getEditedX",
      "getEditedY",
      "getSearchInput",
      "getLoading",
    ]),
    editedX: {
      get() {
        return this.getEditedX;
      },
      set(value) {
        return this.setEditedX(value);
      },
    },
    editedY: {
      get() {
        return this.getEditedY;
      },
      set(value) {
        return this.setEditedY(value);
      },
    },
    searchInput: {
      get() {
        return this.getSearchInput;
      },
      set(value) {
        return this.updateSearchInput(value);
      },
    },
    isLoading: {
      get() {
        return this.getLoading;
      },
      set(value) {
        return this.setLoading(value);
      },
    },
    pageCount() {
      return Math.ceil(
        this.tableDatas.length / this.$store.state.ITEMS_PER_PAGE
      );
    },
  },
  created() {
    try {
      this.$socket.$subscribe("doomroom_get_in", (data) => this.getIn());
      this.$socket.$subscribe("doomfacility_get_in", (data) => this.getIn());
      this.$socket.$subscribe("doomroom_get_out", (data) => this.getOut());
      this.$socket.$subscribe("doomfacility_get_out", (data) => this.getOut());
    } catch (error) {
      window.location.reload();
    }
  },
  methods: {
    ...mapMutations(["deleteRoomPicker"]),
    ...mapMutations("doom_monitoring", [
      "changeEditMode",
      "setEditedX",
      "setEditedY",
      "setFocusPickerId",
      "setFocusRoom",
      "updateSearchInput",
      "setLoading",
    ]),
    ...mapActions("doom_monitoring", [
      "FETCH_CURRENT_LOCATION_BEACON",
      "EDIT_ROOM_PICKER",
      "DELETE_ROOM_PICKER",
    ]),
    getIn() {
      window.location.reload();
    },
    getOut() {
      window.location.reload();
    },
    closeDialog() {
      this.dialog = false;
    },
    submitForm() {
      // this.ADD_EVENT();
      this.closeDialog();
    },
    editModeChanged() {
      this.changeEditMode();
      // 저장 -> 편집 (저장 했을 경우)
      if (this.editMode === false) {
        this.EDIT_ROOM_PICKER();
      }
    },
    onDrag(x, y) {
      this.editedX = x;
      this.editedY = y;
    },
    createRoomIcon(floor) {
      console.log(floor);
      this.dialog = false;
    },
    deleteRoomIcon() {
      this.DELETE_ROOM_PICKER();
      window.location.reload();
    },
    pickerClicked(name, beaconId, roomPickerId) {
      this.setFocusPickerId(roomPickerId);
      this.setFocusRoom(name);
      // beaconId에 해당하는 시설에 있는 인원 목록
      this.FETCH_CURRENT_LOCATION_BEACON(beaconId);
    },
    test() {},
  },
};
</script>
