<template>
  <v-row>
    <v-col
      cols="12"
      xl="8"
      class="mx-auto"
    >
      <v-row>
        <v-col
          cols="5"
          class="mt-5"
        >
          <v-card>
            <v-card-title>
              영외 시설 모니터링
            </v-card-title>
            <v-data-table
              :headers="monitoringHeaders"
              :items="outsideFacilityList"
              hide-default-footer
              :items-per-page="outsideFacilityList.length+5"
              class="elavation-1"
              @click:row="rowClick"
            />
          </v-card>
        </v-col>

        <!-- People list -->
        <v-col
          cols="7"
          class="mt-5"
        >
          <v-card>
            <v-card-title>
              <span>{{ focusRoom }} 인원현황</span>
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
              :headers="peopleHeaders"
              :items="peopleDatas"
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
</template>

<script>
import { deleteOutsideFacility } from "@/api/index.js";
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";

export default {
  name: "Monitoring",
  data() {
    return {
      page: 1,
    };
  },
  computed: {
    ...mapState(["outsideFacilityList"]),
    ...mapState("outside_monitoring", [
      "monitoringHeaders",
      "peopleHeaders",
      "peopleDatas",
      "focusRoom",
    ]),
    ...mapGetters("outside_monitoring", ["getSearchInput"]),
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
        this.peopleDatas.length / this.$store.state.ITEMS_PER_PAGE
      );
    },
  },
  created() {
    try {
      this.$socket.$subscribe("outside_facility_get_in", (data) =>
        this.getIn()
      );
      this.$socket.$subscribe("outside_facility_get_out", (data) =>
        this.getOut()
      );
    } catch (error) {
      window.location.reload();
    }
  },
  methods: {
    ...mapMutations("outside_monitoring", ["updateSearchInput", "setFocusRoom"]),
    ...mapActions("outside_monitoring", ["FETCH_CURRENT_LOCATION_BEACON"]),
    getIn() {
      window.location.reload();
    },
    getOut() {
      window.location.reload();
    },
    rowClick(row) {
      this.setFocusRoom(row.name);
      this.FETCH_CURRENT_LOCATION_BEACON(row.beacon_id);
    },
  },
};
</script>
