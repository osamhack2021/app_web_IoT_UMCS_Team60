module.exports = {
  devServer: {
    proxy: {
      '/api': {
        target: 'http://127.0.0.1:3010',
      },
    }
  },
  // publicPath: process.env.NODE_ENV === "production" ? "./" : "",
  outputDir: '../Server/public',
  transpileDependencies: ["vuetify"],
  indexPath: 'index_build.html',
};
