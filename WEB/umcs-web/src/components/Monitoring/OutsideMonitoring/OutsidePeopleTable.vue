<template>
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
</template>

<script>
import { mapState, mapGetters, mapMutations } from "vuex";

export default {
  name: "OutsidePeopleTable",
  data() {
    return {
      page: 1,
    };
  },
  computed: {
    ...mapState("outside_monitoring", [
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
  methods: {
    ...mapMutations("outside_monitoring", ["updateSearchInput"]),
  },
};
</script>
