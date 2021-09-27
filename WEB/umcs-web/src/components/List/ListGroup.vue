<template>
  <v-list-group
    eager
  >
    <template v-slot:activator>
      <v-list-item-content>
        <v-list-item-title>
          {{ item.title }}
        </v-list-item-title>
      </v-list-item-content>
    </template>

    <template v-for="(child, index) in item.items">
      <default-list-group
        v-if="child.items"
        :key="`sub-group-${index}`"
        :item="child"
      />
      <default-list-item
        v-else
        :key="`child-${index}`"
        :item="child"
      />
    </template>
  </v-list-group>
</template>

<script>
import DefaultListItem from './ListItem'
import DefaultListGroup from './ListGroup'

export default {
  name: "DefaultListGroup",
  components: {
    DefaultListItem,
    DefaultListGroup,
  },
  props: {
    item: {
      type: Object,
      default: () => ({}),
    }
  },
}
</script>

<style scoped>

</style>
