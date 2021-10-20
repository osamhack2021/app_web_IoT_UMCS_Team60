<template>
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
                  <v-list-item-content v-text="data.item.name" />
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
                  @click:minute="$refs.startTimeMenuREF.save(startTime)"
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
                  @click:minute="$refs.endTimeMenuREF.save(endTime)"
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
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";

export default {
  name: "ScheduleCreationForm",
  data: () => ({
    dialog: false,
    startTime: null,
    startTimeMenu: false,
    endTime: null,
    endTimeMenu: false,
  }),
  computed: {
    ...mapState("facility", ["roomList"]),
    ...mapGetters("facility", ["getFormSelectedDoomRoom"]),
    formSelectedDoomRoom: {
      get() {
        return this.getFormSelectedDoomRoom;
      },
      set(value) {
        return this.setFormSelectedDoomRoom(value);
      },
    },
  },
  methods: {
    ...mapMutations("facility", ["setFormSelectedDoomRoom"]),
    ...mapActions("facility", ["CREATE_SCHEDULE"]),

    allowedMinutes: (v) => v % 5 === 0,
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
