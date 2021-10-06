module.exports = {
  devServer: {
    disableHostCheck: true,
    proxy: {
      '/api': {
        target: 'https://militaryumcs.com',
      },
    }
  },
  transpileDependencies: ["vuetify"],
};
