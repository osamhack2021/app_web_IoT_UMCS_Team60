import Vue from "vue";
import Vuetify from "vuetify/lib/framework";
import colors from 'vuetify/lib/util/colors';

Vue.use(Vuetify);

export default new Vuetify({
  theme: {
    themes: {
      light: {
        primary: colors.green,
        // secondary color 고민해봐야 함
        secondary: '#FADCAC',
      }
    }
  }
});
