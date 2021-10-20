<template>
  <v-row>
    <v-col class="my-4">
      <v-alert
        v-if="coronaSituation"
        outlined
        type="error"
        prominent
        text
      >
        <v-row align="center">
          <v-col class="grow font-weight-medium">
            현재 부대는 코로나 격리 상황 유지중입니다
          </v-col>
          <v-col class="shrink">
            <v-btn
              color="secondary"
              @click="changeOfSituation_toNormal"
            >
              평시 상황으로 전환
            </v-btn>
          </v-col>
        </v-row>
      </v-alert>
      <v-alert
        v-else
        outlined
        type="success"
        prominent
        text
      >
        <v-row align="center">
          <v-col class="grow font-weight-medium">
            현재 부대에는 코로나 격리 상황이 발생하지 않았습니다
          </v-col>
          <v-col class="shrink">
            <v-btn
              color="secondary"
              @click="changeOfSituation_toCohort"
            >
              코로나 격리 상황으로 전환
            </v-btn>
          </v-col>
        </v-row>
      </v-alert>
    </v-col>
  </v-row>
</template>

<script>
import { mapState, mapMutations } from "vuex";

export default {
  name: "CoronaSituationBanner",
  computed: {
    ...mapState(["coronaSituation"]),
  },
  methods: {
    ...mapMutations(["setCoronaSituation"]),
    changeOfSituation_toCohort() {
      this.setCoronaSituation(true);
      this.$socket.client.emit("to_cohort");
    },
    changeOfSituation_toNormal() {
      this.setCoronaSituation(false);
      this.$socket.client.emit("to_normal");
    },
  }
};
</script>
