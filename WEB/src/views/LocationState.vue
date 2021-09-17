<template>
  <div>
    <h1>채팅방</h1>
    <ul>
      <li v-for="(msg, index) in messages" :key="index">{{msg}}</li>
    </ul>
    <div>
      <input type="text" @keyup.enter="sendMessage()" v-model="message">
      <button @click="sendMessage()">send</button>
    </div>

  </div>
</template>

<script>
import io from 'socket.io-client';

export default {
  name: 'room',
  data() {
    return {
      messages: [],
      // transports : ['websocket'] 옵션으로 cors 해결
      socket : io('https://osamhack2021-app-web-iot-umcs-team60-pvpvjw57c9pxq-3002.githubpreview.dev', { transports : ['websocket'] })
    }
  },
  methods: {
    sendMessage() {
      console.log("send to server: " + this.message);
      this.socket.emit("chat message", {
        message : this.message
      });
    }
  },
  mounted() {
    this.socket.on('chat message', (data) => {
      console.log("receive from server: " + this.message);
      this.messages = [...this.messages, data.message];
    });
  }
}
</script>