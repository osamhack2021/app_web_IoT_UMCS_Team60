<template>
  <v-container>
    <v-card
      max-width="500"
      class="mx-auto my-12"
    >
      <div class="d-flex justify-center">
        <v-avatar
          size="150"
          class="my-6"
        >
          <v-img
            src="@/assets/default-profile.svg"
            alt="Default Profile"
          />
        </v-avatar>
      </div>
      <v-card-title class="subheading font-weight-bold">
        {{ user.rank }} {{ user.name }}
      </v-card-title>

      <v-divider />

      <v-list dense>
        <v-list-item>
          <v-list-item-content>군번</v-list-item-content>
          <v-list-item-content class="align-end">
            {{ user.tag }}
          </v-list-item-content>
        </v-list-item>
        <v-list-item>
          <v-list-item-content>소속</v-list-item-content>
          <v-list-item-content class="align-end">
            {{ user.doom_id }}생활관
          </v-list-item-content>
        </v-list-item>
        <v-list-item>
          <v-list-item-content>호실</v-list-item-content>
          <v-list-item-content class="align-end">
            {{ user.room_id }}호실
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-card>
  </v-container>
</template>

<script>
import { fetchUserInfo } from "@/api/index.js";

export default {
  name: "UserProfile",
  data: () => ({
    user: {},
  }),
  created() {
    const tag = this.$route.params.id;
    // userTag를 이용하여 User Data 불러오기
    fetchUserInfo(tag)
      .then((response) => (this.user = response.data.data))
      .catch((error) => console.log(error));
  },
};
</script>
