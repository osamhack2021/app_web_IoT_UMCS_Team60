<template>
  <!-- Admin Plus -->
  <v-dialog
    v-model="dialog"
    width="600"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        color="info"
        dark
        v-bind="attrs"
        v-on="on"
      >
        <v-icon>mdi-plus</v-icon>
      </v-btn>
    </template>
    <v-card class="pa-3">
      <v-card-title>
        <span class="text-h5">관리자 등록</span>
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-row>
            <!-- Name -->
            <v-col cols="6">
              <v-text-field
                label="이름"
                required
              />
            </v-col>
          </v-row>
          <!-- Start Date -->
          <v-row>
            <v-col cols="2">
              <v-text-field
                label="년"
                single-line
                required
                value="2021"
              />
            </v-col>
            <v-col cols="1">
              <v-text-field
                label="월"
                single-line
                required
              />
            </v-col>
            <v-col cols="1">
              <v-text-field
                label="일"
                single-line
                required
              />
            </v-col>
            <v-col cols="1" />
            <v-col cols="1">
              <v-text-field
                label="시"
                single-line
                required
              />
            </v-col>
            <v-col cols="1">
              <v-text-field
                label="분"
                single-line
                required
              />
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="2">
              <v-text-field
                label="Year"
                single-line
                required
                value="2021"
              />
            </v-col>
            <v-col cols="1">
              <v-text-field
                label="월"
                single-line
                required
              />
            </v-col>
            <v-col cols="1">
              <v-text-field
                label="일"
                single-line
                required
              />
            </v-col>
            <v-col cols="1" />
            <v-col cols="1">
              <v-text-field
                label="시"
                single-line
                required
              />
            </v-col>
            <v-col cols="1">
              <v-text-field
                label="분"
                single-line
                required
              />
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
      <v-card-actions>
        <v-spacer />
        <v-btn
          color="blue darken-1"
          text
          class="text-body-1 font-weight-medium"
          @click="dialog = false"
        >
          닫기
        </v-btn>
        <v-btn
          color="blue darken-1"
          text
          class="text-body-1 font-weight-medium"
          @click="dialog = false"
        >
          저장
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data: () => ({
    dialog: false,
  }),
};
</script>
