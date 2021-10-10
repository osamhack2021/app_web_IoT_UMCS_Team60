module.exports = {
  chainWebPack: config => {
    config.resolve.alias.set('@', path.resolve(__dirname, 'src/'))
  },
  devServer: {
    disableHostCheck: true,
    proxy: {
      '/api': {
        target: 'https://militaryumcs.com',
      },
    }
  },
  publicPath: process.env.NODE_ENV === "production" ? "./" : "",
  outputDir: '../Server/build',
  transpileDependencies: ["vuetify"],
};
