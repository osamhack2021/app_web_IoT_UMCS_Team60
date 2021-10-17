<template>
  <v-container>
    <v-row>
      <v-col
        cols="12"
        xl="8"
        class="mx-auto"
      >
        <v-row>
          <v-col class="my-4">
            <v-alert
              v-if="coronaSituation"
              outlined
              type="error"
              prominent
              text
            >
              <v-row align="center">
                <v-col class="grow font-weight-medium">
                  현재 부대는 코로나 격리 상황 유지중입니다
                </v-col>
                <v-col class="shrink">
                  <v-btn
                    color="secondary"
                    @click="changeOfSituation_toNormal()"
                  >
                    평시 상황으로 전환
                  </v-btn>
                </v-col>
              </v-row>
            </v-alert>
            <v-alert
              v-else
              outlined
              type="success"
              prominent
              text
            >
              <v-row align="center">
                <v-col class="grow font-weight-medium">
                  현재 부대에는 코로나 격리 상황이 발생하지 않았습니다
                </v-col>
                <v-col class="shrink">
                  <v-btn
                    color="secondary"
                    @click="changeOfSituation_toCohort()"
                  >
                    코로나 격리 상황으로 전환
                  </v-btn>
                </v-col>
              </v-row>
            </v-alert>
          </v-col>
        </v-row>

        <v-row>
          <!-- Facility List Info -->
          <v-col
            cols="12"
            sm="6"
          >
            <v-card>
              <v-list expand>
                <!-- List Title -->
                <v-list-item>
                  <v-list-item-title class="text-h5 py-4">
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

          <!-- Data Table -->
          <v-col
            cols="12"
            sm="6"
          >
            <v-card>
              <v-card-title> 용사 목록 </v-card-title>
              <v-data-table
                :headers="tableHeaders"
                :items="userList"
                :search="searchInput"
                hide-default-footer
                :items-per-page="$store.state.ITEMS_PER_PAGE"
                :page.sync="page"
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
            </v-card>
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
  name: "ManageArmy",
  data: () => ({
    page: 1,
  }),
  computed: {
    ...mapState(["coronaSituation", "userList", "facilityList"]),
    ...mapState("army", ["tableHeaders"]),
    ...mapGetters("army", ["getSearchInput"]),
    searchInput: {
      get() {
        return this.getSearchInput;
      },
      set(value) {
        return this.updateSearchInput(value);
      },
    },
    pageCount() {
      return Math.ceil(this.userList.length / this.$store.state.ITEMS_PER_PAGE);
    },
  },
  methods: {
    ...mapMutations(["setCoronaSituation"]),
    ...mapMutations("army", ["updateSearchInput"]),
    changeOfSituation_toCohort() {
      this.setCoronaSituation(true);
      this.$socket.client.emit("to_cohort");
    },
    changeOfSituation_toNormal() {
      this.setCoronaSituation(false);
      this.$socket.client.emit("to_normal");
    },
  },
};
</script>
