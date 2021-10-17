<template>
  <v-container>
    <v-row class="d-flex justify-center align-center mt-5">
      <v-col cols="6">
        <v-img src="@/assets/UMCS.png" />
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
          <v-row>
            <v-col
              cols="12"
              sm="6"
            >
              <v-text-field
                v-model="adminTag"
                :rules="adminTagRules"
                label="군번"
                required
              />
            </v-col>
            <v-col
              cols="12"
              sm="6"
            >
              <v-text-field
                v-model="password"
                :rules="passwordRules"
                label="비밀번호"
                required
              />
            </v-col>
            <v-col
              cols="12"
              sm="6"
            >
              <v-select
                v-model="rank"
                :items="items"
                :rules="rankRules"
                label="계급"
              />
            </v-col>
            <v-col
              cols="12"
              sm="6"
            >
              <v-text-field
                v-model="name"
                :rules="nameRules"
                label="이름"
                required
              />
            </v-col>
            <v-col
              cols="12"
              sm="6"
              class="mx-auto"
            >
              <v-radio-group
                v-model="auth"
                row
              >
                <v-radio
                  label="상위 관리자"
                  :value="1"
                />
                <v-radio
                  label="하위 관리자"
                  :value="0"
                />
              </v-radio-group>
            </v-col>
          </v-row>
          <v-btn
            type="submit"
            :disabled="!valid"
            color="success"
            block
            class="mt-4 mr-4"
          >
            Sign Up
          </v-btn>
        </v-form>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { signupAdmin } from "@/api/index.js";

export default {
  name: "LoginForm",
  data: () => ({
    valid: true,
    adminTag: "",
    // 군번 유효성 검사 필요 ('-' 포함, 숫자로만 이루어졌는지)
    adminTagRules: [(v) => !!v || "군번을 입력하세요"],
    password: "",
    passwordRules: [(v) => !!v || "비밀번호를 입력하세요"],
    items: ["대장", "중장", "소장", "준장", "대령", "중령", "소령", "대위", "중위", "소위", "준위", "원사", "상사", "중사", "하사"],
    rank: "",
    rankRules: [(v) => !!v || "계급을 선택하세요"],
    name: "",
    nameRules: [(v) => !!v || "이름을 입력하세요"],
    auth: 1,
  }),

  methods: {
    async submitForm() {
      try {
        const isValid = this.$refs.form.validate(); // 유효성 검사
        if (isValid) {
          const adminData = {
            tag: this.adminTag,
            password: this.password,
            name: this.name,
            rank: this.rank,
            auth: this.auth,
          };
          const response = await signupAdmin(adminData);
          console.log(response);
          this.$router.push("/authentication/login");
        }
      } catch (error) {
        console.log(error);
        console.log(error.response.data);
      }
    },
  },
};
</script>
