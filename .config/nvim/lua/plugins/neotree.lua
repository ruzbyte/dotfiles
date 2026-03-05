return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- Für die schönen Datei-Icons
            "MunifTanjim/nui.nvim", -- Hilfs-Plugin für die UI
        },
        config = function()
            -- Den alten Standard-Dateimanager von Vim (Netrw) deaktivieren,
            -- damit Neo-tree komplett übernehmen kann
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            require("neo-tree").setup({
                close_if_last_window = true, -- Schließt Neovim, wenn Neo-tree das letzte Fenster ist
                window = {
                    width = 30, -- Breite des Seitenfensters
                },
            })

            -- Keymap zum Öffnen/Schließen (Space + e wie in LazyVim)
            vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle File Explorer" })
        end,
    },
}
