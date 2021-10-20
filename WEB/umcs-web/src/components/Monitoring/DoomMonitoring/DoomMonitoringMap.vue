<template>
  <div>
    <div
      v-for="doom in facilityList"
      :key="doom.doom_id"
    >
      <v-card class="mt-5">
        <v-card-actions>
          <v-row>
            <v-spacer />
            <v-col cols="3">
              <!-- Dialog for Create Icon -->
              <v-dialog
                v-model="dialog"
                width="600"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    block
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
                        <!-- Select Manage Doom -->
                        <v-col
                          cols="12"
                          sm="4"
                        >
                          <v-select
                            v-model="formDoomId"
                            :items="facilityList"
                            label="건물 선택"
                            item-text="doom_name"
                            item-value="doom_id"
                            prepend-icon="mdi-home-city"
                          >
                            <template v-slot:selection="data">
                              {{ data.item.doom_name }}
                            </template>
                            <template v-slot:item="data">
                              <v-list-item-content v-text="data.item.doom_name" />
                            </template>
                          </v-select>
                        </v-col>
                        <v-col
                          cols="12"
                          sm="4"
                        >
                          <v-select
                            v-model="formFloor"
                            :items="selectedFloorList"
                            label="층 선택"
                            item-text="name"
                            item-value="floor"
                          >
                            <template v-slot:selection="data">
                              {{ data.item.name }}
                            </template>
                            <template v-slot:item="data">
                              <v-list-item-content v-text="data.item.name" />
                            </template>
                          </v-select>
                        </v-col>
                        <v-col
                          cols="12"
                          sm="4"
                        >
                          <v-select
                            v-model="formRoomBeaconId"
                            :items="selectedRoomList"
                            label="장소 선택"
                            item-text="name"
                            item-value="beacon_id"
                          >
                            <template v-slot:selection="data">
                              {{ data.item.name }}
                            </template>
                            <template v-slot:item="data">
                              <v-list-item-content v-text="data.item.name" />
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
              </v-dialog>
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
        </v-card-actions>

        <!-- v-for 사용하여 나열 -->
        <v-card
          v-for="floor in doom.items"
          :key="floor.floor"
          outlined
          class="mt-2 mb-7"
        >
          <!-- Toolbar -->
          <v-card-title class="py-2">
            {{ floor.name }}
          </v-card-title>

          <v-img :src="require(`@/assets/doom${doom.doom_id}-floor${floor.floor}-drawing.png`)">
            <template v-for="picker in floor.items">
              <vue-draggable-resizable
                v-if="picker.room_picker"
                :key="picker.beacon_id"
                :w="1"
                :h="1"
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
  </div>
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";
import VueDraggableResizable from "vue-draggable-resizable";

export default {
  name: "DoomMonitoringMap",
  components: {
    VueDraggableResizable,
  },
  data: () => ({
    dialog: false,
    tempFloorList: ["1층", "2층"],
    tempRoomList: [
      "1호실",
      "2호실",
      "3호실",
      "4호실",
      "5호실",
      "세탁실",
      "화장실",
      "세면장",
      "샤워실",
      "체력단련실",
    ],
  }),
  computed: {
    ...mapState(["facilityList", "selectedFloorList", "selectedRoomList"]),
    ...mapState("doom_monitoring", ["editMode"]),
    ...mapGetters(["getFormDoomId", "getFormFloor", "getFormRoomBeaconId"]),
    ...mapGetters("doom_monitoring", [
      "getEditText",
      "getEditedX",
      "getEditedY",
    ]),
    formDoomId: {
      get() {
        return this.getFormDoomId;
      },
      set(value) {
        return this.setFormDoomId(value);
      },
    },
    formFloor: {
      get() {
        return this.getFormFloor;
      },
      set(value) {
        return this.setFormFloor(value);
      },
    },
    formRoomBeaconId: {
      get() {
        return this.getFormRoomBeaconId;
      },
      set(value) {
        return this.setFormRoomBeaconId(value);
      },
    },
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
  },
  methods: {
    ...mapMutations(["setFormDoomId", "setFormFloor", "setFormRoomBeaconId"]),
    ...mapMutations("doom_monitoring", [
      "changeEditMode",
      "setEditedX",
      "setEditedY",
      "setFocusPickerId",
      "setFocusRoom",
    ]),
    ...mapActions("doom_monitoring", [
      "FETCH_CURRENT_LOCATION_BEACON",
      "CREATE_ROOM_PICKER",
      "EDIT_ROOM_PICKER",
    ]),
    closeDialog() {
      this.dialog = false;
    },
    submitForm() {
      const payload = {
        x: 0, // default x pos
        y: 45, // default y pos
        size: "small", // default button size
        beacon_id: this.formRoomBeaconId, // beacon id to create
      };
      this.closeDialog();
      this.CREATE_ROOM_PICKER(payload);
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
    pickerClicked(name, beaconId, roomPickerId) {
      this.setFocusPickerId(roomPickerId);
      this.setFocusRoom(name);
      // beaconId에 해당하는 시설에 있는 인원 목록
      this.FETCH_CURRENT_LOCATION_BEACON(beaconId);
    },
  },
};
</script>
