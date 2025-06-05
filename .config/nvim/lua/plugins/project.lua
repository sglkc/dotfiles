return {
  {
    'ahmedkhalf/project.nvim',
    opts = {
      silent_chdir = false,
    },
    config = function(_, opts)
      require('project_nvim').setup(opts)
      require('telescope').load_extension('projects')
    end
  }
}
