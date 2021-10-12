<template>
  <v-container>
    <h1>Test</h1>
    <p>{{ response }}</p>
    <v-btn @click="btnEvent">
      코호트전환
    </v-btn>
    <span> {{ $socket.connected ? 'Connected' : 'Disconnected' }} </span>
  </v-container>
</template>

<script>
import Vue from "vue";
import io from "socket.io-client";
import VueSocketIO from "vue-socket.io-extended";

export default {
  name: "Test",
  data() {
    return {
      socket: io("https://militaryumcs.com/manager", {
        transports: ["websocket"],
      }),
      response: {},
    };
  },
  methods: {
    btnEvent() {
      console.log(this.$socket.client);
      this.$socket.client.emit("to_cohort");
    },
  },
  sockets: {
    connect() {
      console.log("socket connected");
    },
  },
  created() {
    Vue.use(VueSocketIO, this.socket);
  },
  mounted() {
    this.$socket.$subscribe("doom_get_in", (data) => {
      console.log(data);
      this.response = data;
    });
    this.$socket.$subscribe("doomroom_get_in", (data) => {
      console.log(data);
      this.response = data;
    });
    this.$socket.$subscribe("doomfacility_get_in", (data) => {
      console.log(data);
      this.response = data;
    });
    this.$socket.$subscribe("outside_facility_get_in", (data) => {
      console.log(data);
      this.response = data;
    });
  },
};
</script>
