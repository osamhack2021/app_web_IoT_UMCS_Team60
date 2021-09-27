<template>
  <v-list expand>
    <!-- List Title -->
    <v-list-item>
      <v-list-item-icon>
        <v-icon>mdi-home</v-icon>
      </v-list-item-icon>
      <v-list-item-title>시설 목록</v-list-item-title>
    </v-list-item>
    <!-- List Content -->
    <template
      v-for="(item, index) in items"
    >
      <default-list-group
        v-if="item.items"
        :key="`group-${index}`"
        :item="item"
      />
      <default-list-item
        v-else
        :key="`item-${index}`"
        :item="item"
      />
    </template>
  </v-list>
</template>

<script>
import DefaultListItem from './ListItem';
import DefaultListGroup from './ListGroup';

export default {
  name: "FacilityList",
  components: {
    DefaultListItem,
    DefaultListGroup,
  },
  props: {
    items: {
      type: Array,
      default: () => [],
    },
  },
};
</script>

<style scoped>
</style>
