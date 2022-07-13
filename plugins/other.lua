local M = {}

M.setup = function()
  require("other-nvim").setup({
    rememberBuffers = false,
    mappings = {
      {
        pattern = "/src/(.*)/(.*).clj",
        target = "/test/%1/%2_test.clj",
        context = "test"
      },
      {
        pattern = "/test/(.*)/(.*)_test.clj",
        target = "/src/%1/%2.clj",
        context = "test"
      },
      {
        pattern = "/lib/(.*)/(.*).ex",
        target = "/test/%1/%2_test.exs",
        context = "test"
      },
      {
        pattern = "/test/(.*)/(.*)_test.exs",
        target = "/lib/%1/%2.ex",
        context = "test"
      },
      {
        pattern = "/lib/(.*)/(.*).rb",
        target = {
          {
            target = "/spec/%1/%2_spec.rb",
            context = "test"
          },
          {
            target = "/spec/lib/%1/%2_spec.rb",
            context = "test",
          }
        }
      },
      {
        pattern = "/spec/(.*)/(.*)_spec.rb",
        target = "/lib/%1/%2.rb",
        context = "test"
      },
      {
        pattern = "/spec/lib/(.*)/(.*)_spec.rb",
        target = "/lib/%1/%2.rb",
        context = "test"
      },
      {
        pattern = "/lib/.*/(.*).rb",
        target = {
          {
            target = "/lib/uplisting/rom/repositories/%1.rb",
            context = "repository",
          },
          {
            target = "/lib/uplisting/entities/%1.rb",
            context = "entity",
          },
          {
            target = "/lib/uplisting/rom/relations/%1s.rb",
            context = "relation",
          }
        }
      },
      {
        pattern = "/lib/.*/(.*)s.rb",
        target = {
          {
            target = "/lib/uplisting/rom/repositories/%1.rb",
            context = "repository",
          },
          {
            target = "/lib/uplisting/entities/%1.rb",
            context = "entity",
          },
        }
      }
    }
  })
end

return M
