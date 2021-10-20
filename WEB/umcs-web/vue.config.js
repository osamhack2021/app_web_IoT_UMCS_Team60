module.exports = {
  devServer: {
    disableHostCheck: true,
  },
  // publicPath: process.env.NODE_ENV === "production" ? "./" : "",
  outputDir: '../Server/public',
  transpileDependencies: ["vuetify"],
  indexPath: 'index_build.html',
};
