return {
  "3rd/image.nvim",
  enabled = false,
  event = {
    "FileType markdown,norg,octo",
    "BufRead *.png,*.jpg,*.gif,*.webp,*.ipynb",
  },
  build = false,
  init = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>i", group = " Images" },
    })
  end,
  config = function()
    require("image").setup({
      processor = "magick_cli",
      backend = "kitty",
      kitty_method = "normal",
      integrations = {
        -- Notice these are the settings for markdown files
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          -- Set this to false if you don't want to render images coming from
          -- a URL
          download_remote_images = true,
          -- Change this if you would only like to render the image where the
          -- cursor is at
          -- I set this to true, because if the file has way too many images
          -- it will be laggy and will take time for the initial load
          only_render_image_at_cursor = false,
          -- markdown extensions (ie. quarto) can go here
          filetypes = { "markdown", "vimwiki", "octo" },
        },
        -- This is disabled by default
        -- Detect and render images referenced in HTML files
        -- Make sure you have an html treesitter parser installed
        -- ~/github/dotfiles-latest/neovim/nvim-lazyvim/lua/plugins/treesitter.lua
        html = {
          enabled = true,
        },
        -- This is disabled by default
        -- Detect and render images referenced in CSS files
        -- Make sure you have a css treesitter parser installed
        -- ~/github/dotfiles-latest/neovim/nvim-lazyvim/lua/plugins/treesitter.lua
        css = {
          enabled = true,
        },
      },
      -- max_width = nil,
      -- max_height = nil,
      -- max_width_window_percentage = math.huge,
      -- max_height_window_percentage = math.huge,

      -- toggles images when windows are overlapped
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },

      -- auto show/hide images when the editor gains/looses focus
      editor_only_render_when_focused = true,

      -- auto show/hide images in the correct tmux window
      -- In the tmux.conf add `set -g visual-activity off`
      tmux_show_only_in_active_window = true,

      -- render image files as images when opened
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    })

    -- Open image under cursor in the Preview app (macOS)
    vim.keymap.set("n", "<leader>io", function()
      local function get_image_path()
        -- Get the current line
        local line = vim.api.nvim_get_current_line()
        -- Pattern to match image path in Markdown
        local image_pattern = "%[.-%]%((.-)%)"
        -- Extract relative image path
        local _, _, image_path = string.find(line, image_pattern)

        return image_path
      end

      -- Get the image path
      local image_path = get_image_path()

      if image_path then
        -- Check if the image path starts with "http" or "https"
        if string.sub(image_path, 1, 4) == "http" then
          print("URL image, use 'gx' to open it in the default browser.")
        else
          -- Construct absolute image path
          local current_file_path = vim.fn.expand("%:p:h")
          local absolute_image_path = current_file_path .. "/" .. image_path

          -- Construct command to open image in Preview
          local command = "open -a Preview " .. vim.fn.shellescape(absolute_image_path)
          -- Execute the command
          local success = os.execute(command)

          if success then
            print("Opened image in Preview: " .. absolute_image_path)
          else
            print("Failed to open image in Preview: " .. absolute_image_path)
          end
        end
      else
        print("No image found under the cursor")
      end
    end, { desc = "(macOS) Open image under cursor in Preview" })

    -- ############################################################################

    -- Open image under cursor in Finder (macOS)
    vim.keymap.set("n", "<leader>if", function()
      local function get_image_path()
        -- Get the current line
        local line = vim.api.nvim_get_current_line()
        -- Pattern to match image path in Markdown
        local image_pattern = "%[.-%]%((.-)%)"
        -- Extract relative image path
        local _, _, image_path = string.find(line, image_pattern)

        return image_path
      end

      -- Get the image path
      local image_path = get_image_path()

      if image_path then
        -- Check if the image path starts with "http" or "https"
        if string.sub(image_path, 1, 4) == "http" then
          print("URL image, use 'gx' to open it in the default browser.")
        else
          -- Construct absolute image path
          local current_file_path = vim.fn.expand("%:p:h")
          local absolute_image_path = current_file_path .. "/" .. image_path

          -- Open the containing folder in Finder and select the image file
          local command = "open -R " .. vim.fn.shellescape(absolute_image_path)
          local success = vim.fn.system(command)

          if success == 0 then
            print("Opened image in Finder: " .. absolute_image_path)
          else
            print("Failed to open image in Finder: " .. absolute_image_path)
          end
        end
      else
        print("No image found under the cursor")
      end
    end, { desc = "(macOS) Open image under cursor in Finder" })

    -- ############################################################################

    -- Delete image file under cursor using trash app (macOS)
    vim.keymap.set("n", "<leader>id", function()
      local function get_image_path()
        -- Get the current line
        local line = vim.api.nvim_get_current_line()
        -- Pattern to match image path in Markdown
        local image_pattern = "%[.-%]%((.-)%)"
        -- Extract relative image path
        local _, _, image_path = string.find(line, image_pattern)

        return image_path
      end

      -- Get the image path
      local image_path = get_image_path()

      if image_path then
        -- Check if the image path starts with "http" or "https"
        if string.sub(image_path, 1, 4) == "http" then
          vim.api.nvim_echo({
            { "URL image cannot be deleted from disk.", "WarningMsg" },
          }, false, {})
        else
          -- Construct absolute image path
          local current_file_path = vim.fn.expand("%:p:h")
          local absolute_image_path = current_file_path .. "/" .. image_path

          -- Check if trash utility is installed
          if vim.fn.executable("trash") == 0 then
            vim.api.nvim_echo({
              { "- Trash utility not installed. Make sure to install it first\n", "ErrorMsg" },
              { "- In macOS run `brew install trash`\n", nil },
            }, false, {})
            return
          end

          -- Prompt for confirmation before deleting the image
          vim.ui.input({
            prompt = "Delete image file? (y/n) ",
          }, function(input)
            if input == "y" or input == "Y" then
              -- Delete the image file using trash app
              local success, _ = pcall(function()
                vim.fn.system({ "trash", vim.fn.fnameescape(absolute_image_path) })
              end)

              if success then
                vim.api.nvim_echo({
                  { "Image file deleted from disk:\n", "Normal" },
                  { absolute_image_path, "Normal" },
                }, false, {})
                -- I'll refresh the images, but will clear them first
                -- I'm using [[ ]] to escape the special characters in a command
                vim.cmd([[lua require("image").clear()]])
                -- Reloads the file to reflect the changes
                vim.cmd("edit!")
              else
                vim.api.nvim_echo({
                  { "Failed to delete image file:\n", "ErrorMsg" },
                  { absolute_image_path, "ErrorMsg" },
                }, false, {})
              end
            else
              vim.api.nvim_echo({
                { "Image deletion canceled.", "Normal" },
              }, false, {})
            end
          end)
        end
      else
        vim.api.nvim_echo({
          { "No image found under the cursor", "WarningMsg" },
        }, false, {})
      end
    end, { desc = "(macOS) Delete image file under cursor" })

    -- ############################################################################

    -- Refresh the images in the current buffer
    -- Useful if you delete an actual image file and want to see the changes
    -- without having to re-open neovim
    vim.keymap.set("n", "<leader>ir", function()
      -- First I clear the images
      -- I'm using [[ ]] to escape the special characters in a command
      vim.cmd([[lua require("image").clear()]])
      -- Reloads the file to reflect the changes
      vim.cmd("edit!")
      print("Images refreshed")
    end, { desc = "Refresh images" })

    -- ############################################################################

    -- Set up a keymap to clear all images in the current buffer
    vim.keymap.set("n", "<leader>ic", function()
      -- This is the command that clears the images
      -- I'm using [[ ]] to escape the special characters in a command
      vim.cmd([[lua require("image").clear()]])
      print("Images cleared")
    end, { desc = "Clear images" })
  end,
}
