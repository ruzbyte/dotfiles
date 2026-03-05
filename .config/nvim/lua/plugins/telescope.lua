return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local builtin = require("telescope.builtin")

        -- Keymaps für Telescope
        -- <leader>ff = Finde Dateien (Find Files)
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })

        -- <leader>fg = Suche Text in allen Dateien (Live Grep)
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })

        -- <leader>fb = Zeige offene Dateien (Buffers)
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })

        -- <leader>fh = Durchsuche die Neovim-Hilfe
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    end,
}
