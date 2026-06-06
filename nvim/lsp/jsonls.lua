-- Install with: `brew install vscode-langservers-extracted`
return {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas({
        select = {
          ".eslintrc",
          "package.json",
        },
      }),
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
  },
}
