<template>
  <div>
    <v-btn v-if="needSelect">
      선택된 항목 모두 승인
    </v-btn>
    <v-card>
      <!-- Search Bar -->
      <v-card-title v-if="needSearch">
        <v-text-field
          v-model="searchValue"
          append-icon="mdi-magnify"
          label="Search"
          single-line
          hide-details
          clearable
        />
      </v-card-title>

      <!-- Data Table -->
      <v-data-table
        v-model="selected"
        :headers="datas.headers"
        :items="datas.datas"
        item-key="name"
        :items-per-page="ITEMS_PER_PAGE"
        :sort-by="['createdTime']"
        :sort-desc="[true]"
        hide-default-footer
        :page.sync="page"
        :search="searchValue"
        :show-select="needSelect"
        class="elavation-1"
      >
        <!-- CRUD -->
        <!-- Slot:top - Toolbar -->
        <template
          v-if="needCRUD"
          v-slot:top
        >
          <v-toolbar flat>
            <v-toolbar-title>공용 시설</v-toolbar-title>
            <v-divider
              class="mx-4"
              inset
              vertical
            />
            <v-spacer />
            <!-- Item Create and Edit Dialog -->
            <v-dialog
              v-model="dialog"
              max-width="500px"
            >
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  color="info"
                  dark
                  class="mb-2"
                  v-bind="attrs"
                  v-on="on"
                >
                  <v-icon>mdi-plus</v-icon>
                </v-btn>
              </template>
              <!-- CRUD Form -->
              <v-card>
                <v-card-title>
                  <span class="text-h5">{{ formTitle }}</span>
                </v-card-title>

                <v-card-text>
                  <v-container>
                    <v-row>
                      <v-col>
                        <v-text-field
                          v-model="inputData.room"
                          label="room"
                        />
                      </v-col>
                      <v-col>
                        <v-text-field
                          v-model="inputData.start"
                          label="start time"
                        />
                      </v-col>
                      <v-col>
                        <v-text-field
                          v-model="inputData.end"
                          label="end time"
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
                    @click="close"
                  >
                    Cancel
                  </v-btn>
                  <v-btn
                    color="blue darken-1"
                    text
                    @click="save"
                  >
                    Save
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
            <!-- Item Delete Dialog -->
            <v-dialog
              v-model="dialogDelete"
              max-width="500px"
            >
              <v-card>
                <v-card-title class="text-h5">
                  Are you sure you want to delete this item?
                </v-card-title>
                <v-card-actions>
                  <v-spacer />
                  <v-btn
                    color="blue darken-1"
                    text
                    @click="closeDelete"
                  >
                    Cancel
                  </v-btn>
                  <v-btn
                    color="blue darken-1"
                    text
                    @click="deleteItemConfirm"
                  >
                    OK
                  </v-btn>
                  <v-spacer />
                </v-card-actions>
              </v-card>
            </v-dialog>
          </v-toolbar>
        </template>

        <!-- Slot:item.actions - Item edit and delete -->
        <template v-slot:[`item.actions`]="{ item }">
          <v-icon
            small
            class="mr-2"
            @click="editItem(item)"
          >
            mdi-pencil
          </v-icon>
          <v-icon
            small
            @click="deleteItem(item)"
          >
            mdi-delete
          </v-icon>
        </template>

        <!-- Slot:item.name - user profile routing -->
        <template v-slot:[`item.name`]="{ item }">
          <router-link
            to="#"
            class="info--text text-decoration-none"
          >
            {{ item.name }}
          </router-link>
        </template>

        <!-- Slot:item.details - Hide details -->
        <template v-slot:[`item.details`]>
          <p>...</p>
        </template>

        <!-- Slot:item.accept - Acception Action -->
        <template v-slot:[`item.accept`]>
          <v-btn>
            승인
          </v-btn>
        </template>

        <!-- Slot:item.reject - Rejection Action -->
        <template v-slot:[`item.reject`]>
          <v-btn>
            거절
          </v-btn>
        </template>
      </v-data-table>
    </v-card>

    <!-- Pagination -->
    <div class="text-center pt-2">
      <v-pagination
        v-model="page"
        :length="pageCount"
        :total-visible="7"
      />
    </div>
  </div>
</template>

<script lang="js">
import { mapState, mapGetters, mapMutations } from "vuex";

export default {
  name: "DefaultDataTable",
  props: {
    datas: {
      type: Object,
      required: true,
    },
    storeName: {
      type: String,
      default: "",
    },
    needSelect: {
      type: Boolean,
      default: false,
    },
    needSearch: {
      type: Boolean,
      default: false,
    },
    needCRUD: {
      type: Boolean,
      default: false,
    },
  },
  data: () => ({
    // CRUD
    dialog: false,
    dialogDelete: false,
    inputData: {
      room: "",
      start: "",
      end: "",
    },

    // Search
    searchValue: null,

    // Select
    selected: [],

    // Common
    page: 1,
    ITEMS_PER_PAGE: 10,
  }),
  computed: {
    ...mapState("facility", [
      "editedIndex",
      "editedItem",
    ]),

    // CRUD
    formTitle() {
      return this.editedIndex === -1 ? "New Item" : "Edit Item";
    },

    // Common
    pageCount() {
      return Math.ceil(this.datas.datas.length / this.ITEMS_PER_PAGE);
    },
  },
  watch: {
    // CRUD
    dialog(val) {
      val || this.close();
    },
    dialogDelete(val) {
      val || this.closeDelete();
    },
  },
  methods: {
    ...mapMutations("facility", [
      "setDefault",
      "setEditedIndex",
      "setEditedItem",
      "pushNewItem",
      "editOneItem",
      "deleteOneItem",
    ]),

    editItem(item) {
      this.inputData = item;
      // this.setEditedIndex(item);
      this.dialog = true;
    },

    deleteItem(item) {
      this.setEditedIndex(item);
      this.setEditedItem(item);
      this.dialogDelete = true;
    },

    deleteItemConfirm() {
      this.deleteOneItem();
      this.closeDelete();
    },

    close() {
      this.dialog = false;
      this.$nextTick(() => {
        this.setDefault();
      });
    },

    closeDelete() {
      this.dialogDelete = false;
      this.$nextTick(() => {
        this.setDefault();
      });
    },

    save() {
      // if (this.editedIndex > -1) {
      //   // this.setEditedItem(this.inputData);
      //   // this.editOneItem();
      //   console.log("hello");
      // } else {
      //   this.pushNewItem();
      // }
      this.close();
    },
  },
};
</script>
