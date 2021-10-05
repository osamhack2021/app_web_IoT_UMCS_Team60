<template>
  <div>
    <!-- Toolbar -->
    <v-sheet height="64">
      <v-toolbar flat>
        <!-- Today Button -->
        <v-btn
          outlined
          class="mr-4"
          color="grey darken-2"
          @click="setToday"
        >
          Today
        </v-btn>
        <!-- prev Button -->
        <v-btn
          fab
          text
          small
          color="grey darken-2"
          @click="prev"
        >
          <v-icon small>
            mdi-chevron-left
          </v-icon>
        </v-btn>
        <!-- next Button -->
        <v-btn
          fab
          text
          small
          color="grey darken-2"
          @click="next"
        >
          <v-icon small>
            mdi-chevron-right
          </v-icon>
        </v-btn>

        <v-spacer />

        <!-- Appear focus Date -->
        <v-toolbar-title v-if="$refs.calendar">
          {{ focus }}
        </v-toolbar-title>
      </v-toolbar>
    </v-sheet>

    <!-- Calendar -->
    <v-sheet height="500">
      <v-calendar
        ref="calendar"
        v-model="focus"
        color="primary"
        type="month"
        @click:date="focusDay"
      />
    </v-sheet>
  </div>
</template>

<script>
export default {
  data: () => ({
    // Calendar
    today: "",
    focus: "",
  }),
  mounted() {
    function leftPad(value) {
      if (value >= 10) {
        return value;
      } else {
        return `0${value}`;
      }
    }

    const today = new Date();
    const year = today.getFullYear();
    const month = leftPad(today.getMonth() + 1);
    const day = leftPad(today.getDate());
    this.today = `${year}-${month}-${day}`;
    this.focus = this.today;
  },
  methods: {
    focusDay({ date }) {
      this.focus = date;
      console.log(this.focus);
    },
    setToday() {
      this.focus = this.today;
    },
    prev() {
      this.$refs.calendar.prev();
    },
    next() {
      this.$refs.calendar.next();
    },
  },
};
</script>

<style scoped>
</style>
