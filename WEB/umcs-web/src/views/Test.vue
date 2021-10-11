<template>
  <v-container>
    <h1>Test</h1>
    <p>{{ response }}</p>
    <v-btn
      @click="btnEvent"
    >
      button
    </v-btn>
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
    this.$socket.on('doom_get_in', (data) => {
      console.log(data);
      this.response = data;
    });
    this.$socket.on('doomroom_get_in', (data) => {
      console.log(data);
      this.response = data;
    });
    this.$socket.on('doomfacility_get_in', (data) => {
      console.log(data);
      this.response = data;
    })

    console.log(this.$socket.connect().connected);
  },
  methods: {
    btnEvent() {
      console.log("btn Clicked!!");
      this.$socket.emit('to_cohort');
    }
  }
};
</script>
