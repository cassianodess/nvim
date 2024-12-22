return {
  {
    'nvim-java/nvim-java',
    dependencies = {
      'folke/neoconf.nvim',
    },
    config = function()
      require('java').setup({
        jdk = {
          auto_install = false
        }
      })
      require('lspconfig').jdtls.setup({
        settings = {
          java = {
            home = os.getenv 'JAVA_HOME' .. '/usr/lib/jvm/java-21-openjdk-amd64',
            configuration = {
              runtimes = {
                {
                  name = 'JavaSE-21',
                  path = os.getenv 'JAVA_HOME' .. '/usr/lib/jvm/java-21-openjdk-amd64',
                  default = true,
                },
                {
                  name = 'JavaSE-17',
                  path = os.getenv 'JAVA_HOME_17' .. '/usr/lib/jvm/java-17-openjdk-amd64',
                },
                {
                  name = 'JavaSE-11',
                  path = os.getenv 'JAVA_HOME_11' .. '/usr/lib/jvm/java-11-openjdk-amd64',
                },
              },
            },
          },
        },
      })
    end,
  },
}
