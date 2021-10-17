<template>
  <v-container>
    <v-row class="d-flex justify-center align-center mt-5">
      <v-col cols="6">
        <v-img
          src="@/assets/UMCS.png"
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
            v-model="adminTag"
            :rules="adminTagRules"
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
        <router-link
          to="/authentication/signup"
          class="text-decoration-none"
        >
          <p class="text-center my-3">
            회원가입
          </p>
        </router-link>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { loginAdmin } from "@/api/index.js";

export default {
  name: "LoginForm",
  data: () => ({
    valid: true,
    adminTag: '',
    // 군번 유효성 검사 필요 ('-' 포함, 숫자로만 이루어졌는지)
    adminTagRules: [
      v => !!v || '군번을 입력하세요',
    ],
    password: '',
    passwordRules: [
      v => !!v || '비밀번호를 입력하세요',
    ],
  }),

  methods: {
    async submitForm () {
      try {
        const isValid = this.$refs.form.validate()  // 유효성 검사
        if (isValid) {
          const adminData = {
            tag: this.adminTag,
            password: this.password
          }
          const response = await loginAdmin(adminData);
          console.log(response);
          this.$router.push("/main");
        }
      } catch(error) {
        console.log(error);
        console.log(error.response.data);
      }
    },
  },
}
</script>
