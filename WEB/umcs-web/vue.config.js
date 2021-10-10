module.exports = {
  devServer: {
    disableHostCheck: true,
    proxy: {
      '/api': {
        target: 'https://militaryumcs.com',
      },
    }
  },
  outputDir: '../Server/build',
  transpileDependencies: ["vuetify"],
};
