local global_node_modules_path = vim.fn.expand('/opt/packages/pnpm/global/5/node_modules/')

return {
  cmd = { "vtsls", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx",
    "vue", "svelte",
  },
  root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
  settings = {
    javascript = {
      suggest = {
        completeFunctionCalls = true,
      },
    },
    typescript = {
      suggest = {
        completeFunctionCalls = true,
      },
    },
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = { enableServerSideFuzzyMatch = true }
      },
      typescript = {
        globalTsdk = global_node_modules_path .. 'typescript/lib'
      },
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = global_node_modules_path .. '@vue/language-server',
            languages = { 'vue' },
            configNamespace = 'typescript',
            enableForWorkspaceTypeScriptVersions = true,
          },
          {
            name = 'typescript-svelte-plugin',
            location = global_node_modules_path .. 'typescript-svelte-plugin',
            languages = { 'svelte' },
            enableForWorkspaceTypeScriptVersions = true,
          }
        },
      },
    },
  },
}
