<template>
  <v-container>
    <v-row>
      <v-col
        cols="12"
        xl="8"
        class="mx-auto"
      >
        <v-row class="mt-5">
          <v-col cols="8">
            <div
              v-for="doom in facilityList"
              :key="doom.doom_id"
            >
              <v-card>
                <!-- Dialog for Create Icon -->
                <v-card-actions>
                  <v-dialog
                    v-model="dialog"
                    max-width="600px"
                  >
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn
                        v-bind="attrs"
                        v-on="on"
                      >
                        추가
                      </v-btn>
                    </template>
                    <v-card>
                      <v-card-title>
                        <span class="text-h5">관리할 장소 추가</span>
                      </v-card-title>
                      <v-form>
                        <v-card-text>
                          <v-container>
                            <v-row>
                              <v-col cols="4">
                                <v-select
                                  v-model="formInput.doom"
                                  label="건물"
                                />
                              </v-col>
                              <v-col cols="4">
                                <v-select
                                  v-model="formInput.floor"
                                  label="층"
                                />
                              </v-col>
                              <v-col cols="4">
                                <v-select
                                  v-model="formInput.name"
                                  label="장소"
                                />
                              </v-col>
                            </v-row>
                          </v-container>
                        </v-card-text>
                        <v-card-actions>
                          <v-spacer />
                          <v-btn
                            color="blue darken-1"
                            text
                            @click="dialog = false"
                          >
                            Close
                          </v-btn>
                          <v-btn
                            color="blue darken-1"
                            text
                            @click="createRoomIcon(floor)"
                          >
                            Save
                          </v-btn>
                        </v-card-actions>
                      </v-form>
                    </v-card>
                  </v-dialog>

                  <v-btn
                    class="ml-2"
                    @click="changeEditMode"
                  >
                    {{ getEditText }}
                  </v-btn>
                  ({{ editedX }}, {{ editedY }})
                </v-card-actions>
              </v-card>
              <!-- v-for 사용하여 나열 -->
              <v-card
                v-for="floor in doom.items"
                :key="floor.floor"
                elevation="7"
                class="mt-5"
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
                        @click="test($event, picker.name, picker.beacon_id)"
                      >
                        {{ picker.current_count }}
                      </v-btn>
                    </vue-draggable-resizable>
                  </template>
                </v-img>
              </v-card>
            </div>
          </v-col>

          <!-- People list -->
          <v-col cols="4">
            <v-card>
              <v-card-title>
                {{ focusRoom }} 인원현황
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
  </v-container>
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
      editedX: 0,
      editedY: 0,
      searchValue: "",
      dialog: false,

      // Create Form
      selectFromItems: {},
      formInput: {
        doom: "",
        floor: "",
        name: "",
      },
    };
  },
  computed: {
    ...mapState(["facilityList"]),
    ...mapState("monitoring", [
      "editMode",
      "focusRoom",
      "tableHeaders",
      "tableDatas",
    ]),
    ...mapGetters("monitoring", ["getEditText", "getSearchInput"]),
    searchInput: {
      get() {
        return this.getSearchInput;
      },
      set(value) {
        return this.updateSearchInput(value);
      },
    },
  },
  created() {
    console.log(this.facilityList);
  },
  methods: {
    ...mapMutations("monitoring", [
      "changeEditMode",
      "setFocusRoom",
      "updateSearchInput",
    ]),
    ...mapActions("monitoring", ["FETCH_CURRENT_LOCATION_BEACON"]),
    onDrag(x, y) {
      this.editedX = x;
      this.editedY = y;
    },
    createRoomIcon(floor) {
      console.log(floor);
      this.dialog = false;
    },
    test(event, name, beaconId) {
      console.log("test is called!");
      console.log("event", event);
      console.log("beaconId", beaconId);
      this.setFocusRoom(name);
      // beaconId에 해당하는 시설에 있는 인원 목록
      this.FETCH_CURRENT_LOCATION_BEACON(beaconId);
    },
  },
};
</script>
