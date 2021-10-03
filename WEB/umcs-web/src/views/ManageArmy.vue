<template>
  <v-container>
    <v-row>
      <v-col>
        <!-- 격리 상황에 따라 다른 컴포넌트 보이기 -->
        <!-- 평시 -->
        <v-banner
          :color="bannerColor"
          elevation="5"
          class="my-5"
        >
          <v-icon
            slot="icon"
            color="warning"
            size="36"
          >
            mdi-wifi-strength-alert-outline
          </v-icon>
          평시, 격리 상황에 대한 Banner

          <template v-slot:actions>
            <v-btn
              color="info"
              text
            >
              Actions
            </v-btn>
          </template>
        </v-banner>
      </v-col>
    </v-row>

    <data-table
      :datas="getAccountDatas"
      :need-search="true"
    />
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import DataTable from '@/components/DataTable'

export default {
  name: "ManageArmy",
  components: {
    DataTable,
  },
  data: () => ({
    bannerColor: "green accent-1",
  }),
  computed: {
    ...mapGetters('army', [
      "getAccountDatas",
    ]),
  }
};
</script>
