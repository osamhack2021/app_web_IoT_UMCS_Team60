<template>
  <v-container>
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

    <!-- Data Table -->
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
    ...mapState(["coronaSituation", "userList"]),
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
