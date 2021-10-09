<template>
  <v-container>
    <v-row
      v-for="doom in floorList"
      :key="doom.doomId"
      dense
    >
      <!-- v-for 사용하여 나열 -->
      <v-col
        v-for="floor in doom.items"
        :key="floor.name"
        cols="12"
        class="mt-6"
      >
        <v-card>
          <v-card-title>
            {{ floor.name }}
          </v-card-title>
          <v-card-actions>
            <v-spacer />
            <v-btn>
              추가
            </v-btn>
            <v-btn>
              편집
            </v-btn>
          </v-card-actions>
          <v-img src="@/assets/doom-drawing.png">
            <vue-draggable-resizable
              class-name="box-content"
              :w="56"
              :h="56"
              :x="325"
              :y="50"
              :draggable="true"
              :resizable="true"
              @dragging="onDrag"
              @resizing="onResize"
            >
              <v-btn
                color="rgba(1, 87, 155, 0.8)"
                fab
                class="white--text"
              >
                5
              </v-btn>
            </vue-draggable-resizable>
          </v-img>
        </v-card>
      </v-col>
      <!-- <v-col
        cols="12"
        class="mt-6"
      >
        <v-card>
          <v-card-actions>
            <v-spacer />
            <v-btn>
              추가
            </v-btn>
            <v-btn>
              편집
            </v-btn>
          </v-card-actions>
          <v-img src="@/assets/doom-drawing.png">
            <vue-draggable-resizable
              class-name="box-content"
              :w="150"
              :h="150"
              :x="176"
              :y="96"
              :draggable="false"
              :resizable="false"
            >
              <p>
                X: {{ x }} / Y: {{ y }}<br>
                Width: {{ width }} / Height: {{ height }}
              </p>
            </vue-draggable-resizable>
          </v-img>
        </v-card>
      </v-col> -->
    </v-row>
  </v-container>
</template>

<script>
/* Note */
/* 화면 띄우는 Logic */
// 건물과 층까지의 data를 받아온다 → (건물이 1개라면) 각 층에 해당하는 건물 도면이 담긴 card를 띄운다
// → 각 층에 해당하는 icon element에 대한 data를 서버로부터 받아와서 띄운다
// → (클릭할 경우) beacon_id를 확인하여 해당 시설에 있는 사람들의 정보를 띄운다

import { mapState, mapGetters, mapMutations, mapActions } from "vuex";
import VueDraggableResizable from "vue-draggable-resizable";

export default {
  name: "Monitoring",
  components: {
    VueDraggableResizable,
  },
  data() {
    return {
      width: 0,
      height: 0,
      x: 0,
      y: 0,
    };
  },
  computed: {
    ...mapState("monitoring", [
      "floorList",
    ])
  },
  methods: {
    onResize(x, y, width, height) {
      this.x = x;
      this.y = y;
      this.width = width;
      this.height = height;
    },
    onDrag(x, y) {
      this.x = x;
      this.y = y;
    },
  },
  mounted() {
    console.log(this.floorList[0].items);
  }
};
</script>

<style scoped>
</style>
