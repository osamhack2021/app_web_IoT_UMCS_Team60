<template>
  <v-card>
    <!-- Search Bar -->
    <v-card-title v-if="needSearch">
      <v-text-field
        v-model="searchValue"
        append-icon="mdi-magnify"
        label="Search"
        single-line
        hide-details
      />
    </v-card-title>
    <!-- Data Table -->
    <v-data-table
      :headers="datas.headers"
      :items="datas.datas"
      :items-per-page="10"
      :loading="isLoading"
      :search="searchValue"
    >
      <template v-slot:[`item.name`]="{ item }">
        <router-link
          to="#"
          class="info--text text-decoration-none"
        >
          {{ item.name }}
        </router-link>
      </template>
    </v-data-table>
  </v-card>
</template>

<script>
export default {
  props: {
    datas: {
      type: Object,
      required: true,
    },
    needSearch: {
      type: Boolean,
      required: true,
    },
  },
  data: () => ({
    // Data Table Search Bar
    searchValue: null,
  }),
  computed: {
    isLoading() {
      return false;
    },
  },
};
</script>

<style scoped>
</style>
