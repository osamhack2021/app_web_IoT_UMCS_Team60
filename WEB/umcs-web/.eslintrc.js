module.exports = {
  extends: ['plugin:vue/recommended'],
  plugins: ['vuetify'],
  parserOptions: {
    parser: "babel-eslint",
  },
  rules: {
    'vuetify/no-deprecated-classes': 'error',
    'vuetify/no-legacy-grid': 'error',
    'indent': ['error', 2],
  },
  overrides: [
    {
      files: [
        "**/__tests__/*.{j,t}s?(x)",
        "**/tests/unit/**/*.spec.{j,t}s?(x)",
      ],
      env: {
        jest: true,
      },
    },
  ],
};

// module.exports = {
//   root: true,
//   env: {
//     node: true,
//   },
//   extends: [
//     "plugin:vue/essential",
//     "eslint:recommended",
//     "@vue/prettier",
//     "plugin:vue/recommended",
//   ],
//   parserOptions: {
//     parser: "babel-eslint",
//   },
//   plugins: ["vuetify"],
//   rules: {
//     "no-console": process.env.NODE_ENV === "production" ? "warn" : "off",
//     "no-debugger": process.env.NODE_ENV === "production" ? "warn" : "off",
//     "vuetify/no-deprecated-classes": "error",
//     "vuetify/no-legacy-grid": "error",
//     indent: ["error", 2],
//   },
//   overrides: [
//     {
//       files: [
//         "**/__tests__/*.{j,t}s?(x)",
//         "**/tests/unit/**/*.spec.{j,t}s?(x)",
//       ],
//       env: {
//         jest: true,
//       },
//     },
//   ],
// };
//
