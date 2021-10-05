<template>
  <v-navigation-drawer
    v-model="drawer"
    app
    dark
  >
    <default-drawer-header />

    <v-divider />

    <v-list
      dense
      nav
    >
      <v-list-item
        v-for="item in items"
        :key="item.title"
        link
        :to="item.to"
        active-class="primary"
        class="py-1"
      >
        <v-list-item-icon>
          <v-icon>{{ item.icon }}</v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-title class="text-body-1 font-weight-regular">
            {{ item.title }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
import { mapState } from 'vuex'
import DefaultDrawerHeader from './DrawerHeader'

export default {
  name: "DefaultDrawer",
  components: {
    DefaultDrawerHeader,
  },
  computed: {
    ...mapState('drawer', {
      items: 'items'
    }),
    drawer: {
      get() {
        return this.$store.getters['drawer/getDrawer']
      },
      set(value) {
        return this.$store.dispatch('drawer/toggleDrawer', value);
      }
    }
  },
}
</script>

<style scoped>

</style>
