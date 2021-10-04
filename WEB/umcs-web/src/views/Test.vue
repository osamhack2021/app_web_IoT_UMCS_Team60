<template>
  <v-container>
    <div
      style="
        height: 800px;
        width: 800px;
        border: 1px solid red;
        position: relative;
      "
    >
      <vue-draggable-resizable
        class-name="drag-box"
        :w="200"
        :h="200"
        :x="0"
        :y="0"
        :draggable="true"
        :resizable="true"
        :parent="true"
        :lock-aspect-ratio="true"
        :handles="['tm', 'bm', 'ml', 'mr']"
        @dragging="onDrag"
        @resizing="onResize"
      >
        <p>
          Hello!<br>
          X: {{ x }} / Y: {{ y }}<br>
          Width: {{ width }} / Height: {{ height }}
        </p>
      </vue-draggable-resizable>
    </div>
  </v-container>
</template>

<script>
import VueDraggableResizable from "vue-draggable-resizable";

export default {
  name: "Test",
  components: {
    VueDraggableResizable,
  },
  data() {
    return {
      width: 0,
      height: 0,
      x: 0,
      y: 0
    }
  },
  methods: {
    onResize(x, y, width, height) {
      this.x = x
      this.y = y
      this.width = width
      this.height = height
    },
    onDrag(x, y) {
      this.x = x
      this.y = y
    }
  }
};
</script>

<style scoped>
.parent-container {
  width: 800px;
  height: 800px;
  margin: 0 auto;
}
.drag-box {
  background-color: rgba(255, 229, 241, 0.7);
  color: red;
}
.drag-box > .content-container > * {
  /* Align center */
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
}
</style>
