<template>
  <v-card>
    <v-list expand>
      <!-- List Title -->
      <v-list-item>
        <v-list-item-title class="text-h5 text-center py-4">
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
              link
              active-class="primary"
              @click="updateSelectedFacility(item.doom_id, item.doomfacility_id, item.name)"
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
import { mapState, mapMutations, mapActions } from "vuex";

export default {
  name: "FacilityList",
  computed: {
    ...mapState(["facilityList"]),
  },
  methods: {
    ...mapMutations("facility", [
      "setSelectedDoomId",
      "setSelectedFacilityId",
      "setSelectedFacilityName",
    ]),
    ...mapActions("facility", ["FETCH_TIME_TABLE", "FETCH_ROOM_LIST"]),
    updateSelectedFacility(doom_id, facility_id, name) {
      const prevSelectedDoomId = this.selectedDoomId;
      this.setSelectedDoomId(doom_id);
      this.setSelectedFacilityId(facility_id);
      this.setSelectedFacilityName(name);
      this.FETCH_TIME_TABLE({ doom_id, facility_id });
      // 이전에 선택했던 시설과 다른 건물에 있다면 호실 목록 다시 불러오기
      if (prevSelectedDoomId != this.selectedDoomId) {
        this.FETCH_ROOM_LIST();
      }
    },
  },
};
</script>
