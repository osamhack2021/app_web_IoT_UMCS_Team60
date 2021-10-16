<template>
  <v-container class="mt-5">
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
                    {{ selectedFacility }} 이용 시간표
                  </v-toolbar-title>
                  <v-spacer />
                  <v-btn
                    color="info"
                    dark
                    @click="createTest()"
                  >
                    <v-icon>mdi-plus</v-icon>
                  </v-btn>
                </v-toolbar>
              </template>
              <!-- Slot:item.actions - display edit, delete icon -->
              <template v-slot:[`item.actions`]>
                <v-icon
                  small
                  class="mx-2"
                >
                  mdi-pencil
                </v-icon>
                <v-icon small>
                  mdi-delete
                </v-icon>
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
import { createTimeTable } from "@/api/index.js";
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";

export default {
  name: "FacilitySchedule",
  data: () => ({
    page: 1,
  }),
  computed: {
    ...mapState(["facilityList"]),
    ...mapState("facility", ["selectedFacility", "tableHeaders", "tableDatas"]),
    ...mapGetters("facility", ["getLoading"]),
    isLoading: {
      get() {
        return this.getLoading;
      },
      set() {
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
    ...mapMutations("facility", ["setSelectedFacility", "setLoading"]),
    ...mapActions("facility", ["FETCH_TIME_TABLE"]),
    updateSelectedFacility(doom_id, facility_id, name) {
      this.setSelectedFacility(name);
      this.FETCH_TIME_TABLE({ doom_id, facility_id });
    },
    createTest() {
      console.log("create Testing...!!");
      const tableData = {
        room_id: 1,
        facility_id: 1,
        start_time: "2021-10-04 20:10:00",
        end_time: "2021-10-04 20:20:00",
      };
      createTimeTable(tableData);
    },
  },
};
</script>

<style scoped></style>
