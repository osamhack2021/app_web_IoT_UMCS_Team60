<template>
  <div>
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
            {{ selectedFacilityName }} 이용 시간표
          </v-toolbar-title>
          <v-spacer />
        </v-toolbar>
      </template>
      <!-- Slot:item.actions - display delete icon -->
      <template v-slot:[`item.actions`]="{ item }">
        <v-btn
          x-small
          @click="DELETE_SCHEDULE(item.id)"
        >
          <v-icon small>
            mdi-delete
          </v-icon>
        </v-btn>
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
  </div>
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";

export default {
  name: "FacilityScheduleTable",
  data: () => ({
    page: 1,
  }),
  computed: {
    ...mapState("facility", [
      "tableHeaders",
      "tableDatas",
      "selectedFacilityName",
    ]),
    ...mapGetters("facility", ["getLoading"]),
    ...mapActions("facility", ["DELETE_SCHEDULE"]),
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
    ...mapMutations("facility", ["setLoading"]),
  },
};
</script>
