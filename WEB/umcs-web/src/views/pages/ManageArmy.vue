<template>
  <v-container>
    <v-row>
      <v-col class="my-4">
        <v-alert
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
              <v-btn color="secondary">
                Take action
              </v-btn>
            </v-col>
          </v-row>
        </v-alert>
        <v-alert
          outlined
          type="error"
          prominent
          text
        >
          <v-row align="center">
            <v-col class="grow font-weight-medium">
              현재 부대는 코로나 격리 상황 유지중입니다.
            </v-col>
            <v-col class="shrink">
              <v-btn color="secondary">
                Take action
              </v-btn>
            </v-col>
          </v-row>
        </v-alert>
      </v-col>
    </v-row>

    <data-table
      :datas="getAccountDatas"
      :need-search="true"
    />

    <v-card>
      {{ userList }}
    </v-card>
  </v-container>
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";
import DataTable from "@/components/DataTable";

export default {
  name: "ManageArmy",
  components: {
    DataTable,
  },
  computed: {
    ...mapState(["userList"]),
    ...mapGetters("army", ["getAccountDatas"]),
  },
};
</script>
