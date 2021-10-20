<template>
  <v-card>
    <v-card-title>
      <v-row>
        <v-col cols="6">
          <!-- Search Bar -->
          <v-text-field
            v-model="searchInput"
            append-icon="mdi-magnify"
            label="Search"
            single-line
            hide-details
            clearable
          />
        </v-col>
        <v-spacer />
        <v-btn
          class="mt-5"
          @click="allAccept()"
        >
          선택된 항목 모두 승인
        </v-btn>
        <v-btn
          class="mt-5 mx-4"
          @click="allReject()"
        >
          선택된 항목 모두 거절
        </v-btn>
      </v-row>
    </v-card-title>

    <!-- Data Table -->
    <v-data-table
      v-model="selectedItems"
      show-select
      :headers="tableHeaders"
      :items="tableDatas"
      item-key="id"
      :sort-by="['reportedTime']"
      :sort-desc="[true]"
      :search="searchInput"
      show-expand
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

      <!-- Slot:item.details - Hide details -->
      <template v-slot:[`item.details`]>
        <p>...</p>
      </template>

      <!-- Slot:item.accept - Acception Action -->
      <template v-slot:[`item.accept`]="{ item }">
        <v-icon @click="acceptReport(item.id)">
          mdi-check-bold
        </v-icon>
      </template>

      <!-- Slot:item.reject - Rejection Action -->
      <template v-slot:[`item.reject`]="{ item }">
        <v-icon @click="rejectReport(item.id)">
          mdi-close-thick
        </v-icon>
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
</template>

<script>
import { mapState, mapGetters, mapMutations } from "vuex";

export default {
  name: "MovingApprovalDataTable",
  data: () => ({
    page: 1,
  }),
  computed: {
    ...mapState("moving_approval", ["tableHeaders", "tableDatas"]),
    ...mapGetters("moving_approval", [
      "getSearchInput",
      "getSelectedItems",
      "getLoading",
    ]),
    searchInput: {
      get() {
        return this.getSearchInput;
      },
      set(value) {
        return this.updateSearchInput(value);
      },
    },
    selectedItems: {
      get() {
        return this.getSelectedItems;
      },
      set(value) {
        return this.updateSelectedItems(value);
      },
    },
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
    ...mapMutations("moving_approval", [
      "updateSearchInput",
      "updateSelectedItems",
      "setLoading",
      "deleteMovingReport",
    ]),
    acceptReport(id) {
      const load = {
        id,
        permission: true,
      };
      this.$socket.client.emit("move_approval", load);
      this.deleteMovingReport(id);
    },
    rejectReport(id) {
      const load = {
        id,
        permission: false,
      };
      this.$socket.client.emit("move_approval", load);
      this.deleteMovingReport(id);
    },
    allAccept() {
      this.selectedItems.forEach((elem) => {
        this.acceptReport(elem.id);
      });
      this.selectedItems = [];
    },
    allReject() {
      this.selectedItems.forEach((elem) => {
        this.rejectReport(elem.id);
      });
      this.selectedItems = [];
    },
  },
};
</script>
