<template>
  <v-row class="fill-height">
    <v-col>
      <!-- Tool Bar -->
      <v-row>
        <!-- Select Range -->
        <v-col cols="4">
          <v-sheet
            tile
            height="54"
            class="d-flex"
          >
            <v-btn
              icon
              class="ma-2"
              @click="prev"
            >
              <v-icon>mdi-chevron-left</v-icon>
            </v-btn>
            <v-btn
              icon
              class="ma-2"
              @click="next"
            >
              <v-icon>mdi-chevron-right</v-icon>
            </v-btn>
          </v-sheet>
        </v-col>
        <v-spacer />
        <!-- Admin Registration -->
        <v-col
          cols="auto"
          class="mr-3 mt-2"
        >
          <admin-registration />
        </v-col>
      </v-row>
      <!-- Calendar -->
      <v-sheet height="600">
        <v-calendar
          ref="calendar"
          v-model="focus"
          color="primary"
          type="month"
          :events="events"
          event-overlap-mode="column"
          :event-color="getEventColor"
          @click:event="showEvent"
          @change="getEvents"
        />
        <!-- Event Popup -->
        <v-menu
          v-model="selectedOpen"
          transition="slide-x-transition"
          :close-on-content-click="false"
          :activator="selectedElement"
          offset-x
        >
          <v-card
            color="grey lighten-4"
            min-width="350px"
            flat
          >
            <v-toolbar
              :color="selectedEvent.color"
              dark
              dense
              flat
            >
              <v-spacer />
              <v-card-actions class="pa-0">
                <v-btn icon>
                  <v-icon>mdi-delete</v-icon>
                </v-btn>
              </v-card-actions>
              <v-card-actions class="pa-0">
                <v-btn
                  icon
                  @click="selectedOpen = false"
                >
                  <v-icon>mdi-close</v-icon>
                </v-btn>
              </v-card-actions>
            </v-toolbar>
            <div class="d-flex justify-center mt-7 mb-2">
              <v-avatar size="100">
                <img
                  src="@/assets/default-profile.svg"
                  alt="Default Profile"
                >
              </v-avatar>
            </div>
            <v-card-text class="d-flex justify-center">
              <div class="text-h6 font-weight-bold">
                {{ selectedEvent.name }}
              </div>
            </v-card-text>
          </v-card>
        </v-menu>
      </v-sheet>
    </v-col>
  </v-row>
</template>

<script>
import { mapState, mapGetters, mapMutations } from "vuex";
import AdminRegistration from "./AdminRegistration";

export default {
  components: {
    AdminRegistration,
  },
  data: () => ({
    focus: "",
    dialog: false,
    events: [],
    selectedEvent: {},
    selectedElement: null,
    selectedOpen: false,
    colors: ["orange"],
  }),
  methods: {
    showEvent({ nativeEvent, event }) {
      const open = () => {
        this.selectedEvent = event;
        this.selectedElement = nativeEvent.target;
        requestAnimationFrame(() =>
          requestAnimationFrame(() => (this.selectedOpen = true))
        );
      };
      if (this.selectedOpen) {
        this.selectedOpen = false;
        requestAnimationFrame(() => requestAnimationFrame(() => open()));
      } else {
        open();
      }

      nativeEvent.stopPropagation();
    },
    getEvents() {
      const events = [
        {
          name: "소위 이소위",
          start: new Date("2021-10-7"),
          color: "orange",
          details: ""
        },
        {
          name: "중위 김중위",
          start: new Date("2021-10-27"),
          color: "orange",
          details: "전역 D-5, 말년 중위 김중위",
        },
        {
          name: "하사 김하사",
          start: "2021-10-12",
          color: "orange",
          details: "",
        },
        {
          name: "상사(진) 송중사",
          start: "2021-10-28",
          // end가 주어지지 않으면 start로 자동 초기화
          color: "orange",
          details: "",
        },
      ];
      this.events = events;
    },
    getEventColor(event) {
      return event.color;
    },
    prev() {
      this.$refs.calendar.prev();
    },
    next() {
      this.$refs.calendar.next();
    },
  },
};
</script>
