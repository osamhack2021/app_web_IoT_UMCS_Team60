<template>
  <v-container>
    <v-row>
      <v-col
        cols="12"
        xl="8"
        class="mx-auto"
      >
        <!-- Corona Situation Banner -->
        <corona-situation-banner />

        <v-row>
          <!-- Facility List Info -->
          <v-col
            cols="12"
            sm="6"
          >
            <army-facility-list />
          </v-col>

          <!-- Data Table -->
          <v-col
            cols="12"
            sm="6"
          >
            <army-user-list />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import CoronaSituationBanner from "@/components/ArmyInfo/CoronaSituationBanner";
import ArmyFacilityList from "@/components/ArmyInfo/FacilityList";
import ArmyUserList from "@/components/ArmyInfo/UserList";

export default {
  name: "ManageArmy",
  components: {
    CoronaSituationBanner,
    ArmyFacilityList,
    ArmyUserList,
  },
};
</script>
