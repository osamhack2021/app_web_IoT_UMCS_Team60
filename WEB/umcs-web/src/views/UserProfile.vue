<template>
  <v-container>
    <p>{{ response }}</p>
  </v-container>
</template>

<script>
import axios from "axios";

export default {
  name: "UserProfile",
  data: () => ({
    response: "",
  }),
  created() {
    const userTag = this.$route.params.id;
    // userTag를 이용하여 User Data 불러오기
    // const data = axios.get(`http://militaryumcs.com/api/user/${userTag}`)
    axios.get("https://dog.ceo/api/breeds/list/all")
      .then(response => {
        console.log(response);
        this.response = response.data;
      })
      .catch(error => console.log(error));
  }
};
</script>
