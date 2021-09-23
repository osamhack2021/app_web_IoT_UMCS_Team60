<template>
  <v-container>
    <v-row class="d-flex justify-center align-center">
      <v-col cols="6">
        <v-img
          src="../assets/UMCS.png"
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
        >
          <v-text-field
            v-model="username"
            :rules="usernameRules"
            label="id"
            required
          />

          <v-text-field
            v-model="password"
            :rules="passwordRules"
            label="password"
            required
          />

          <v-btn
            :disabled="!valid"
            color="success"
            block
            class="mt-4 mr-4"
            @click="validate"
          >
            <!-- Validate -->
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
    username: '',
    usernameRules: [
      v => !!v || 'id is required',
    ],
    password: '',
    passwordRules: [
      v => !!v || 'password is required',
    ],
  }),

  methods: {
    validate () {
      this.$refs.form.validate()
    },
    reset () {
      this.$refs.form.reset()
    },
    resetValidation () {
      this.$refs.form.resetValidation()
    },
  },
}
</script>

<style scoped>

</style>
