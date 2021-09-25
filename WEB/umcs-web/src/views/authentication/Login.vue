<template>
  <v-container>
    <v-row class="d-flex justify-center align-center">
      <v-col cols="6">
        <v-img
          src="@/assets/UMCS.png"
          max-height="330"
        />
      </v-col>
    </v-row>
    <v-row class="d-flex justify-center align-center mt-0">
      <v-col cols="6">
        <v-form
          ref="form"
          v-model="valid"
          lazy-validation
          @submit.prevent="submitForm"
        >
          <v-text-field
            v-model="userNum"
            :rules="userNumRules"
            label="군번"
            required
          />

          <v-text-field
            v-model="password"
            :rules="passwordRules"
            label="비밀번호"
            required
          />

          <v-btn
            type="submit"
            :disabled="!valid"
            color="success"
            block
            class="mt-4 mr-4"
          >
            Login
          </v-btn>
        </v-form>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data: () => ({
    valid: true,
    userNum: '',
    // 군번 유효성 검사 필요 ('-' 포함, 숫자로만 이루어졌는지)
    userNumRules: [
      v => !!v || 'id is required',
    ],
    password: '',
    passwordRules: [
      v => !!v || 'password is required',
    ],
  }),

  methods: {
    submitForm () {
      const isValid = this.$refs.form.validate()  // 유효성 검사
      if (isValid) {
        this.$router.push("main");
      }
    },
  },
}
</script>

<style scoped>

</style>
