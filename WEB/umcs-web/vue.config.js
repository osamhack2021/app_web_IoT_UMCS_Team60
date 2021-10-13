module.exports = {
  devServer: {
    proxy: {
      '/api': {
        target: 'https://militaryumcs.com/',
      },
    }
  },
  // publicPath: process.env.NODE_ENV === "production" ? "./" : "",
  outputDir: '../Server/public',
  transpileDependencies: ["vuetify"],
  indexPath: 'index_build.html',
};
