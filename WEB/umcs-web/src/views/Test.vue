<template>
  <v-container>
    <h1>Test</h1>
    <v-btn @click="btnEvent">
      Button
    </v-btn>
  </v-container>
</template>

<script>
import {
  fetchRoomPickerList,
  createRoomPicker,
  deleteRoomPicker,
  createFacility,
  deleteFacility,
} from "@/api/index.js";

export default {
  name: "Test",
  data: () => ({
    data: {
      x: 120,
      y: 105,
      size: "small",
      name: "2호실",
      beacon_id: "hh:hh:hh:hh:hh:hh"
    },
  }),
  methods: {
    btnEvent() {
      createRoomPicker(this.data)
        .then((response) => console.log(response))
        .catch((error) => console.log(error));
      // deleteRoomPicker(11)
      //   .then((response) => console.log(response))
      //   .catch((error) => console.log(error));
      // deleteRoomPicker(12)
      //   .then((response) => console.log(response))
      //   .catch((error) => console.log(error));
    },
  },
};
</script>
