<template>
  <v-container class="mt-5">
    <v-row class="fill-height">
      <!-- Calendar -->
      <v-col cols="4">
        <v-date-picker
          v-model="picker"
          elevation="15"
          full-width
          show-adjacent-months
          class="pb-5"
          @change="updateTable"
        />
      </v-col>

      <v-spacer />

      <v-col cols="7">
        <v-card>
          <!-- Search Bar -->
          <v-card-title>
            <v-text-field
              v-model="searchInput"
              append-icon="mdi-magnify"
              label="Search"
              single-line
              hide-details
              clearable
            />
          </v-card-title>

          <!-- Data Table -->
          <v-data-table
            :headers="tableHeaders"
            :items="tableDatas"
            item-key="tag"
            :sort-by="['reported_time']"
            :sort-desc="[true]"
            :search="searchInput"
            show-expand
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

            <!-- Slot:expanded.item -->
            <template v-slot:expanded-item="{ headers, item }">
              <td :colspan="headers.length">
                {{ item.details }}
              </td>
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
  </v-container>
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";

export default {
  data: () => ({
    // vuex 안써도 될 거 같은 값들
    page: 1,
  }),
  computed: {
    ...mapState("health", ["tableHeaders", "tableDatas"]),
    ...mapGetters("health", ["getPicker", "getSearchInput"]),
    picker: {
      get() {
        return this.getPicker;
      },
      set(value) {
        return this.setPickedDate(value);
      },
    },
    searchInput: {
      get() {
        return this.getSearchInput;
      },
      set(value) {
        return this.updateSearchInput(value);
      },
    },
    pageCount() {
      return Math.ceil(
        this.tableDatas.length / this.$store.state.ITEMS_PER_PAGE
      );
    },
  },
  created() {
    // 현재 날짜 저장
    const today = new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
      .toISOString()
      .substr(0, 10);
      // YYYY-MM-DD
    this.setPickedDate(today);
    // data Table init
    this.updateTable(this.picker);
  },
  methods: {
    ...mapMutations("health", ["setPickedDate", "updateSearchInput"]),
    ...mapActions("health", ["FETCH_HEALTH_REPORT"]),
    updateTable(date) {
      // (API호출) 선택할 날짜에 해당하는 건강보고 기록 가져오기
      this.FETCH_HEALTH_REPORT(date);
    },
  },
};
</script>
