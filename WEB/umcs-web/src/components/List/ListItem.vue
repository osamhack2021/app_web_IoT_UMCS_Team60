<template>
  <div>
    <v-list-item
      link
      active-class="primary"
    >
      <v-list-item-content>
        <v-list-item-title>
          {{ item.title }}
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>
  </div>
</template>

<script>
export default {
  name: "DefaultListItem",
  props: {
    item: {
      type: Object,
      default: () => ({}),
    },
  },
};
</script>

<style scoped>
</style>
