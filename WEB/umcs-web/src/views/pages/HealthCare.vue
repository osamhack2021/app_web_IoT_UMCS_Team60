<template>
  <v-container class="mt-5">
    <v-row class="fill-height">
      <!-- Calendar -->
      <v-col cols="5">
        <v-date-picker
          v-model="picker"
          elevation="15"
          full-width
          show-adjacent-months
          class="pb-5"
        />
      </v-col>

      <v-spacer />

      <v-col cols="6">
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
            :items-per-page="$store.state.ITEMS_PER_PAGE"
            :sort-by="['createdTime']"
            :sort-desc="[true]"
            hide-default-footer
            :page.sync="page"
            :search="searchInput"
            class="elavation-1"
          >
            <!-- Slot:item.details - Hide details -->
            <template v-slot:[`item.details`]>
              <p>...</p>
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
import { mapState, mapGetters, mapMutations } from "vuex";

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
        console.log("picker is updated!!");
        // (API호출) 선택할 날짜에 해당하는 건강보고 기록 가져오기
        return this.setPickedDate(value);
      }
    },
    searchInput: {
      get() {
        return this.getSearchInput;
      },
      set(value) {
        return this.updateSearchInput(value);
      }
    },
    pageCount() {
      return Math.ceil(
        this.tableDatas.length / this.$store.state.ITEMS_PER_PAGE
      );
    },
  },
  created() {
    const today = new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
      .toISOString()
      .substr(0, 10);
    this.setPickedDate(today); // YYYY-MM-DD
  },
  methods: {
    ...mapMutations("health", ["setPickedDate", "updateSearchInput"]),
  },
};
</script>

<style scoped>
</style>
