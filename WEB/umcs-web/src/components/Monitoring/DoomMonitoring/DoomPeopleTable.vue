<template>
  <v-card>
    <v-card-title>
      <span>{{ focusRoom }} 인원현황</span>
      <v-spacer />
      <v-icon
        v-if="focusPickerId"
        @click="deleteRoomIcon"
      >
        mdi-delete
      </v-icon>
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
      :headers="tableHeaders"
      :items="tableDatas"
      :search="searchInput"
      :loading="isLoading"
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
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";

export default {
  name: "DoomPeopleTable",
  data: () => ({
    page: 1,
  }),
  computed: {
    ...mapState("doom_monitoring", [
      "focusPickerId",
      "focusRoom",
      "tableHeaders",
      "tableDatas",
    ]),
    ...mapGetters("doom_monitoring", ["getSearchInput", "getLoading"]),
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
        this.tableDatas.length / this.$store.state.ITEMS_PER_PAGE
      );
    },
  },
  methods: {
    ...mapMutations(["deleteRoomPicker"]),
    ...mapMutations("doom_monitoring", ["updateSearchInput", "setLoading"]),
    ...mapActions("doom_monitoring", ["DELETE_ROOM_PICKER"]),
    deleteRoomIcon() {
      this.DELETE_ROOM_PICKER();
    },
  },
};
</script>
