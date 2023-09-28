return function()
  local actions = require "telescope.actions"
  local project_actions = require "telescope._extensions.project.actions"
  local fb_actions = require "telescope._extensions.file_browser.actions"

  return {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          ["<C-n>"] = require("telescope.actions").cycle_history_next,
          ["<C-p>"] = require("telescope.actions").cycle_history_prev,
          ["<C-a>"] = { "<home>", type = "command" },
          ["<C-e>"] = { "<end>", type = "command" },
        },
      },
      file_ignore_patterns = { "node_modules", "resources/public/js/", ".git/", ".shadow-cljs/" },
      extensions = {
        file_browser = {
          mappings = {
            i = {
              ["<Tab>"] = actions.select_default,
              ["<C-CR>"] = fb_actions.create_from_prompt
            },
          },
        },
        project = {
          base_dirs = { "~/Development/", "~/.config/nvim/lua/" },
          on_project_selected = function(prompt_bufnr)
            -- Do anything you want in here. For example:
            project_actions.change_working_directory(prompt_bufnr, false)
            -- project_actions.find_project_files(prompt_bufnr, false)
          end,
        },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        advanced_git_search = {
          -- fugitive or diffview
          diff_plugin = "fugitive",
          -- customize git in previewer
          -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
          git_flags = {},
          -- customize git diff in previewer
          -- e.g. flags such as { "--raw" }
          git_diff_flags = {},
        },
      },
      extensions_list = { "themes", "terms", "file_browser", "smart_history", "fzf", "project" }
    }
  }
end
