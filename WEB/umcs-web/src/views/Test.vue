<template>
  <v-container>
    <h1>Test</h1>
    <p>{{ response }}</p>
    <v-btn
      @click="btnEvent"
    >
      코호트로전환
    </v-btn>
    <span>{{$socket.connected ? 'Connected' : 'Disconnected'}}</span>
  </v-container>
</template>

<script>
export default {
  name: "Test",
  data() {
    return {
      response: {},
    }
  },
  mounted() {
    this.$socket.$subscribe('doom_get_in', payload => {
      console.log(payload)
      this.response = payload;
    });
    this.$socket.$subscribe('doomroom_get_in', payload => {
      console.log(payload)
      this.response = payload;
    });
    this.$socket.$subscribe('doomfacility_get_in', payload => {
      console.log(payload)
      this.response = payload;
    });
    this.$socket.$subscribe('outside_facility_get_in', payload => {
      console.log(payload)
      this.response = payload;
    });
  },
  
  methods: {
    btnEvent() {
      console.log(this.$socket.client);
      this.$socket.client.emit('to_normal');
    }
  },
  sockets: {
    connect() {
      console.log('socket connected')
    },
    doom_get_in(data) {
      console.log(data);
    }
  }
};
</script>