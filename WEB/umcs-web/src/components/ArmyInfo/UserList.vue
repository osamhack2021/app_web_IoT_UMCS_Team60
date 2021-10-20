<template>
  <div>
    <v-card>
      <v-row>
        <v-col>
          <v-card-title> 용사 목록 </v-card-title>
        </v-col>
        <v-spacer />
        <v-col>
          <v-card-actions>
            <v-dialog
              v-model="dialog"
              width="400"
            >
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  color="secondary"
                  v-bind="attrs"
                  v-on="on"
                >
                  긴급 소집
                </v-btn>
              </template>
              <v-card class="pa-3">
                <v-card-title>
                  <span class="text-h5">긴급소집할 범위 선택</span>
                </v-card-title>
                <v-card-text>
                  <v-container>
                    <v-row>
                      <v-col
                        cols="12"
                        align-self="center"
                      >
                        <v-select
                          v-model="doomToCall"
                          :items="doomList"
                          label="Select"
                          item-text="id"
                          prepend-icon="mdi-home-city"
                          required
                        >
                          <template v-slot:selection="data">
                            {{ data.item.name }}
                          </template>
                          <template v-slot:item="data">
                            <v-list-item-content v-text="data.item.name" />
                          </template>
                        </v-select>
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
                    @click="closeDialog"
                  >
                    닫기
                  </v-btn>
                  <v-btn
                    color="blue darken-1"
                    text
                    class="text-body-1 font-weight-medium"
                    @click="emergencyCall"
                  >
                    저장
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
          </v-card-actions>
        </v-col>
      </v-row>
      <v-data-table
        :headers="tableHeaders"
        :items="userList"
        :search="searchInput"
        hide-default-footer
        :items-per-page="$store.state.ITEMS_PER_PAGE"
        :page.sync="page"
      >
        <!-- Slot:item.name - user profile routing -->
        <template v-slot:[`item.name`]="{ item }">
          <router-link
            :to="`/user/${item.tag}`"
            class="info--text text-decoration-none"
          >
            {{ item.name }}
          </router-link>
        </template>
      </v-data-table>
    </v-card>
    <!-- Pagination -->
    <div class="text-center pt-2">
      <v-pagination
        v-model="page"
        :length="pageCount"
        :total-visible="$store.state.TOTAL_VISIBLE"
      />
    </div>
  </div>
</template>

<script>
import { mapState, mapGetters, mapMutations } from "vuex";

export default {
  name: "ArmyUserList",
  data: () => ({
    page: 1,
    dialog: false,
  }),
  computed: {
    ...mapState(["userList", "doomList"]),
    ...mapState("army", ["tableHeaders"]),
    ...mapGetters("army", ["getSearchInput", "getFormDoom"]),
    searchInput: {
      get() {
        return this.getSearchInput;
      },
      set(value) {
        return this.updateSearchInput(value);
      },
    },
    pageCount() {
      return Math.ceil(this.userList.length / this.$store.state.ITEMS_PER_PAGE);
    },
    doomToCall: {
      get() {
        return this.getFormDoom;
      },
      set(value) {
        return this.setFormDoom(value);
      },
    },
  },
  methods: {
    ...mapMutations("army", ["updateSearchInput", "setFormDoom"]),
    closeDialog() {
      this.dialog = false;
    },
    emergencyCall() {
      const payload = {
        doom_id: this.getFormDoom,
      };
      this.$socket.client.emit("assemble_command", payload);
      this.closeDialog();
    },
  },
};
</script>
