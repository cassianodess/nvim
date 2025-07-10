return {
  {
    -- Quando o jdtls parar de funcionar, é só remover o .cache
    -- rm -rf .cache/jdtls/workspace
    'nvim-java/nvim-java',
    dependencies = {
      'folke/neoconf.nvim',
    },
    config = function()
      require('lspconfig').jdtls.setup({
        flags = { debounce_text_changes = 150 },
        settings = {
          java = {
            format = { enabled = false },
            home = os.getenv 'JAVA_HOME' .. '/usr/lib/jvm/java-21-openjdk-amd64',
            configuration = {
                runtimes = {
                {
                  name = 'JavaSE-11',
                  path = os.getenv 'JAVA_HOME_11',
                },
                {
                  name = 'JavaSE-17',
                  path = os.getenv 'JAVA_HOME_17',
                },
                {
                  name = 'JavaSE-21',
                  path = os.getenv 'JAVA_HOME_21',
                  default = true,
                },
              },
            },
          },
        },
      })
    end,
  },
}