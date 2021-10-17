<template>
  <v-container class="mt-6">
    <v-row>
      <v-col
        cols="12"
        xl="8"
        class="mx-auto"
      >
        <v-row>
          <!-- Facility List Info -->
          <v-col cols="5">
            <v-card>
              <v-list expand>
                <!-- List Title -->
                <v-list-item>
                  <v-list-item-title class="text-h5 text-center py-4">
                    시설 목록
                  </v-list-item-title>
                </v-list-item>

                <!-- List Content -->
                <!-- Doom List -->
                <v-list-group
                  v-for="doomList in facilityList"
                  :key="doomList.doom_id"
                  eager
                >
                  <template v-slot:activator>
                    <v-list-item-icon>
                      <v-icon>mdi-home-city</v-icon>
                    </v-list-item-icon>
                    <v-list-item-title>
                      {{ doomList.doom_name }}
                    </v-list-item-title>
                  </template>

                  <!-- Floor List -->
                  <v-list-group
                    v-for="floorList in doomList.items"
                    :key="floorList.floor"
                    eager
                  >
                    <template v-slot:activator>
                      <v-list-item-title>
                        {{ floorList.name }}
                      </v-list-item-title>
                    </template>

                    <!-- Facility List -->
                    <template v-for="item in floorList.items">
                      <v-list-item
                        v-if="item.doomfacility_id"
                        :key="item.beacon_id"
                        link
                        active-class="primary"
                        @click="
                          updateSelectedFacility(
                            item.doom_id,
                            item.doomfacility_id,
                            item.name
                          )
                        "
                      >
                        <!-- Facility Item -->
                        <v-list-item-content>
                          <v-list-item-title>
                            {{ item.name }}
                          </v-list-item-title>
                        </v-list-item-content>
                      </v-list-item>
                    </template>
                  </v-list-group>
                </v-list-group>
              </v-list>
            </v-card>
          </v-col>

          <!-- Facility Time Table -->
          <v-col cols="7">
            <v-data-table
              :headers="tableHeaders"
              :items="tableDatas"
              :sort-by="['startTime']"
              :loading="isLoading"
              hide-default-footer
              :items-per-page="$store.state.ITEMS_PER_PAGE"
              :page.sync="page"
              class="elevation-1"
            >
              <!-- Slot:top - customizing data table top -->
              <template v-slot:top>
                <v-toolbar flat>
                  <v-toolbar-title>
                    {{ selectedFacilityName }} 이용 시간표
                  </v-toolbar-title>
                  <v-spacer />
                  <v-dialog
                    v-model="dialog"
                    width="450"
                  >
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn
                        color="info"
                        dark
                        v-bind="attrs"
                        v-on="on"
                      >
                        <v-icon>mdi-plus</v-icon>
                      </v-btn>
                    </template>
                    <v-card class="pa-3">
                      <v-card-title>
                        <span class="text-h5">공용시설 이용시간 추가</span>
                      </v-card-title>
                      <v-card-text>
                        <v-container>
                          <v-row>
                            <!-- 호실 설정  -->
                            <v-col cols="12">
                              <v-select
                                v-model="formSelectedDoomRoom"
                                :items="roomList"
                                label="이용할 호실"
                                item-text="id"
                                prepend-icon="mdi-home"
                                required
                              >
                                <template v-slot:selection="data">
                                  {{ data.item.name }}
                                </template>
                                <template v-slot:item="data">
                                  <v-list-item-content
                                    v-text="data.item.name"
                                  />
                                </template>
                              </v-select>
                            </v-col>
                            <!-- 시작 시각 설정 -->
                            <v-col cols="12">
                              <v-menu
                                ref="startTimeMenuREF"
                                v-model="startTimeMenu"
                                :close-on-content-click="false"
                                :nudge-right="40"
                                :return-value.sync="startTime"
                                transition="scale-transition"
                                offset-y
                                max-width="300px"
                              >
                                <template v-slot:activator="{ on, attrs }">
                                  <v-text-field
                                    v-model="startTime"
                                    label="시작 시각"
                                    prepend-icon="mdi-clock-time-four-outline"
                                    readonly
                                    v-bind="attrs"
                                    v-on="on"
                                  />
                                </template>
                                <v-time-picker
                                  v-if="startTimeMenu"
                                  v-model="startTime"
                                  :allowed-minutes="allowedMinutes"
                                  format="24hr"
                                  full-width
                                  @click:minute="
                                    $refs.startTimeMenuREF.save(startTime)
                                  "
                                />
                              </v-menu>
                            </v-col>
                            <!-- 종료 시각 설정 -->
                            <v-col cols="12">
                              <v-menu
                                ref="endTimeMenuREF"
                                v-model="endTimeMenu"
                                :close-on-content-click="false"
                                :nudge-right="40"
                                :return-value.sync="endTime"
                                transition="scale-transition"
                                offset-y
                                max-width="300px"
                              >
                                <template v-slot:activator="{ on, attrs }">
                                  <v-text-field
                                    v-model="endTime"
                                    label="종료 시각"
                                    prepend-icon="mdi-clock-time-four-outline"
                                    readonly
                                    v-bind="attrs"
                                    v-on="on"
                                  />
                                </template>
                                <v-time-picker
                                  v-if="endTimeMenu"
                                  v-model="endTime"
                                  :allowed-minutes="allowedMinutes"
                                  format="24hr"
                                  full-width
                                  @click:minute="
                                    $refs.endTimeMenuREF.save(endTime)
                                  "
                                />
                              </v-menu>
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
                </v-toolbar>
              </template>
              <!-- Slot:item.actions - display edit, delete icon -->
              <template v-slot:[`item.actions`]="{ item }">
                <v-btn
                  x-small
                  @click="DELETE_SCHEDULE(item.id)"
                >
                  <v-icon small>
                    mdi-delete
                  </v-icon>
                </v-btn>
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
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";

export default {
  name: "FacilitySchedule",
  data: () => ({
    page: 1,
    dialog: false,
    startTime: null,
    startTimeMenu: false,
    endTime: null,
    endTimeMenu: false,
  }),
  computed: {
    ...mapState(["facilityList"]),
    ...mapState("facility", [
      "roomList",
      "selectedDoomId",
      "selectedFacilityName",
      "tableHeaders",
      "tableDatas",
    ]),
    ...mapGetters("facility", ["getFormSelectedDoomRoom", "getLoading"]),
    formSelectedDoomRoom: {
      get() {
        return this.getFormSelectedDoomRoom;
      },
      set(value) {
        return this.setFormSelectedDoomRoom(value);
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
  methods: {
    ...mapMutations("facility", [
      "setFormSelectedDoomRoom",
      "setSelectedDoomId",
      "setSelectedFacilityId",
      "setSelectedFacilityName",
      "setLoading",
    ]),
    ...mapActions("facility", [
      "FETCH_ROOM_LIST",
      "FETCH_TIME_TABLE",
      "CREATE_SCHEDULE",
      "DELETE_SCHEDULE",
    ]),
    updateSelectedFacility(doom_id, facility_id, name) {
      const prevSelectedDoomId = this.selectedDoomId;
      this.setSelectedDoomId(doom_id);
      this.setSelectedFacilityId(facility_id);
      this.setSelectedFacilityName(name);
      this.FETCH_TIME_TABLE({ doom_id, facility_id });
      // 이전에 선택했던 시설과 다른 건물에 있다면 호실 목록 다시 불러오기
      if (prevSelectedDoomId != this.selectedDoomId) {
        this.FETCH_ROOM_LIST();
      }
    },
    allowedMinutes: v => v % 5 === 0,
    closeDialog() {
      this.dialog = false;
    },
    submitForm() {
      const today = new Date(
        Date.now() - new Date().getTimezoneOffset() * 60000
      )
        .toISOString()
        .substr(0, 10);
      const payload = {
        startTime: `${today} ${this.startTime}:00`,
        endTime: `${today} ${this.endTime}:00`,
      };
      this.closeDialog();
      this.CREATE_SCHEDULE(payload);
    },
  },
};
</script>
