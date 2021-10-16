<template>
  <v-container>
    <v-row>
      <v-col
        cols="12"
        xl="8"
        class="mx-auto"
      >
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
                    class="ma-2"
                    @click="prev"
                  >
                    <v-icon>mdi-chevron-left</v-icon>
                  </v-btn>
                  <v-btn
                    class="ma-2"
                    @click="next"
                  >
                    <v-icon>mdi-chevron-right</v-icon>
                  </v-btn>
                </v-sheet>
              </v-col>
              <v-spacer />
              <!-- Create Admin Duty Event -->
              <v-col
                cols="auto"
                class="mr-3 mt-2"
              >
                <v-dialog
                  v-model="dialog"
                  width="600"
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
                      <span class="text-h5">관리자 등록</span>
                    </v-card-title>
                    <v-card-text>
                      <v-container>
                        <v-row>
                          <!-- Select Admin on duty -->
                          <v-col
                            cols="12"
                            sm="6"
                          >
                            <v-select
                              v-model="adminOnDuty"
                              :items="adminList"
                              label="관리자"
                              item-text="tag"
                              prepend-icon="mdi-account"
                              required
                            >
                              <template v-slot:selection="data">
                                {{ data.item.identity }}
                              </template>
                              <template v-slot:item="data">
                                <v-list-item-content v-text="`${data.item.tag} ${data.item.identity}`" />
                              </template>
                            </v-select>
                          </v-col>
                          <!-- Select Manage Doom -->
                          <v-col
                            cols="12"
                            sm="6"
                          >
                            <v-select
                              v-model="doomOnDuty"
                              :items="doomList"
                              label="부대 선택"
                              item-text="id"
                              prepend-icon="mdi-home-city"
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
                          <!-- Select Date on duty -->
                          <v-col
                            cols="12"
                            sm="8"
                          >
                            <v-menu
                              v-model="displayMenu"
                              :close-on-content-click="false"
                              transition="scale-transition"
                              offset-y
                              min-width="auto"
                            >
                              <template v-slot:activator="{ on, attrs }">
                                <v-text-field
                                  v-model="dateOnDuty"
                                  label="날짜 선택"
                                  prepend-icon="mdi-calendar"
                                  readonly
                                  v-bind="attrs"
                                  v-on="on"
                                />
                              </template>
                              <v-date-picker
                                v-model="dateOnDuty"
                                no-title
                                @input="displayMenu = false"
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
                        @click="closeDialog()"
                      >
                        닫기
                      </v-btn>
                      <v-btn
                        color="blue darken-1"
                        text
                        class="tet-body-1 font-weight-medium"
                        @click="saveForm()"
                      >
                        저장
                      </v-btn>
                    </v-card-actions>
                  </v-card>
                </v-dialog>
              </v-col>
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
                      <v-btn
                        icon
                        @click="deleteEvent()"
                      >
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
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";

export default {
  name: "ManageAdmin",
  data: () => ({
    dialog: false,
  }),
  computed: {
    ...mapState(["adminList", "doomList"]),
    ...mapState("admin", ["events", "selectedEvent", "selectedElement"]),
    ...mapGetters("admin", [
      "getSelectedDate",
      "getSelectedOpen",
      "getFormAdmin",
      "getFormDate",
      "getDisplayMenu",
      "getFormDoom",
    ]),
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
    adminOnDuty: {
      get() {
        return this.getFormAdmin;
      },
      set(value) {
        return this.setFormAdmin(value);
      },
    },
    dateOnDuty: {
      get() {
        return this.getFormDate;
      },
      set(value) {
        return this.setFormDate(value);
      },
    },
    displayMenu: {
      get() {
        return this.getDisplayMenu;
      },
      set(value) {
        return this.setDisplayMenu(value);
      },
    },
    doomOnDuty: {
      get() {
        return this.getFormDoom;
      },
      set(value) {
        return this.setFormDoom(value);
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
      "setFormAdmin",
      "setFormDate",
      "setDisplayMenu",
      "setFormDoom",
    ]),
    ...mapActions("admin", ["FETCH_ADMIN_INFO", "ADD_EVENT", "DELETE_EVENT"]),
    prev() {
      this.$refs.calendar.prev();
    },
    next() {
      this.$refs.calendar.next();
    },
    closeDialog() {
      this.dialog = false;
    },
    saveForm() {
      this.ADD_EVENT();
      this.closeDialog();
    },
    deleteEvent() {
      this.DELETE_EVENT(this.selectedEvent.id);
    },
  },
};
</script>

<style scoped></style>
