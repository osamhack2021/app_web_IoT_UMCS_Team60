<template>
  <v-container>
    <!-- Calendar -->
    <v-row class="fill-hegiht">
      <v-col>
        <!-- Tool Bar  -->
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
              {{ selectedDate }}
            </v-sheet>
          </v-col>
          <v-spacer />
          <!-- Admin Registration -->
        </v-row>

        <!-- Calendar -->
        <v-sheet height="600">
          <v-calendar
            ref="calendar"
            v-model="selectedDate"
            color="primary"
            type="month"
            :events="events"
            event-overlap-mode="column"
            @click:event="showEvent"
            @change="FETCH_ADMIN_INFO()"
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
                    @click="selectedOpen=false"
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
  </v-container>
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";

export default {
  name: "ManageAdmin",
  computed: {
    ...mapState("admin", ["events", "selectedEvent", "selectedElement"]),
    ...mapGetters("admin", ["getSelectedDate", "getSelectedOpen"]),
    selectedDate: {
      get() {
        return this.getSelectedDate;
      },
      set(value) {
        return this.setSelectedDate(value);
      },
    },
    selectedOpen: {
      get() {
        return this.getSelectedOpen;
      },
      set(value) {
        return this.setSelectedOpen(value);
      },
    },
  },
  created() {
    // selectedDate를 현재 날짜로 initializing
    const today = new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
      .toISOString()
      .substr(0, 10);
    this.setSelectedDate(today);
  },
  methods: {
    ...mapMutations("admin", [
      "setSelectedDate",
      "setSelectedOpen",
      "updateEvents",
      "showEvent",
    ]),
    ...mapActions("admin", [
      "FETCH_ADMIN_INFO",
    ]),
    prev() {
      this.$refs.calendar.prev();
    },
    next() {
      this.$refs.calendar.next();
    },
  },
};
</script>

<style scoped></style>
