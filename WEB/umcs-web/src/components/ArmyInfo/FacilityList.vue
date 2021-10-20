<template>
  <v-card>
    <v-list expand>
      <!-- List Title -->
      <v-list-item>
        <v-list-item-title class="text-h5 py-4">
          시설 목록
        </v-list-item-title>
      </v-list-item>

      <!-- List Content -->
      <!-- Doom List -->
      <v-list-group
        v-for="doomList in facilityList"
        :key="doomList.doom_id"
        eager
      >
        <template v-slot:activator>
          <v-list-item-icon>
            <v-icon>mdi-home-city</v-icon>
          </v-list-item-icon>
          <v-list-item-title>
            {{ doomList.doom_name }}
          </v-list-item-title>
        </template>

        <!-- Floor List -->
        <v-list-group
          v-for="floorList in doomList.items"
          :key="floorList.floor"
          eager
        >
          <template v-slot:activator>
            <v-list-item-title>
              {{ floorList.name }}
            </v-list-item-title>
          </template>

          <!-- Facility List -->
          <template v-for="item in floorList.items">
            <v-list-item
              v-if="item.doomfacility_id"
              :key="item.beacon_id"
            >
              <!-- Facility Item -->
              <v-list-item-content>
                <v-list-item-title>
                  {{ item.name }}
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </template>
        </v-list-group>
      </v-list-group>
    </v-list>
  </v-card>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "ArmyFacilityList",
  computed: {
    ...mapState(["facilityList"])
  },
};
</script>
