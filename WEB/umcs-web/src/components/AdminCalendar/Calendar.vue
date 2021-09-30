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
            <v-select
              v-model="type"
              :items="types"
              dense
              outlined
              hide-details
              class="ma-2"
              label="type"
            />
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
          :type="type"
          :events="events"
          :event-overlap-mode="mode"
          :event-overlap-threshold="30"
          :event-color="getEventColor"
          @click:event="showEvent"
          @change="getEvents"
        />
        <!-- Event Popup -->
        <v-menu
          v-model="selectedOpen"
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
            >
              <v-toolbar-title>
                {{ selectedEvent.name }}
              </v-toolbar-title>
              <v-spacer />
              <v-card-actions>
                <v-btn icon>
                  <v-icon>mdi-delete</v-icon>
                </v-btn>
              </v-card-actions>
              <v-card-actions>
                <v-btn
                  icon
                  @click="selectedOpen = false"
                >
                  <v-icon>mdi-close</v-icon>
                </v-btn>
              </v-card-actions>
            </v-toolbar>
            <v-card-text>
              <span>
                {{ selectedEvent.details }}
              </span>
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
    type: "month",
    types: ["month", "week", "day"],
    focus: "",
    mode: "column",
    dialog: false,
    events: [],
    selectedEvent: {},
    selectedElement: null,
    selectedOpen: false,
    colors: ["orange"],
  }),
  // computed: {
  //   ...mapState("admin", [
  //     "events",
  //     "selectedEvent",
  //     "selectedElement",
  //     "selectedOpen",
  //     "colors",
  //   ]),
  //   ...mapGetters("admin", ["getEvents", "getEventColor"]),
  // },
  methods: {
    // ...mapMutations('admin', [
    //   "showEvent"
    // ]),
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
          name: "김중위",
          start: new Date("2021-09-27T00:00:00"),
          end: new Date("2021-09-27T08:30:00"),
          color: "orange",
          details: "전역 D-5, 말년 중위 김중위",
          timed: true,
        },
        {
          name: "김하사",
          start: "2021-09-15T15:00:00",
          end: new Date("2021-09-15T22:00:00"),
          color: "orange",
          details: "",
          timed: true,
        },
        {
          name: "송중사",
          start: "2021-09-28T13:30:00",
          end: "2021-09-28T18:45:00",
          color: "orange",
          details: "",
          timed: true,
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
