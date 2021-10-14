<template>
  <v-container>
    <p>{{ resData }}</p>
  </v-container>
</template>

<script>
import { fetchUserInfo } from "@/api/index.js";

export default {
  name: "UserProfile",
  data: () => ({
    resData: {},
  }),
  created() {
    const tag = this.$route.params.id;
    // userTag를 이용하여 User Data 불러오기
    fetchUserInfo(tag)
      .then((response) => this.resData = response.data.data)
      .catch((error) => console.log(error));
  },
};
</script>
