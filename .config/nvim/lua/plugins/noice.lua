return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- Hier kannst du einstellen, was alles in die Mitte soll
            lsp = {
                -- Fortschrittsbalken beim Laden von LSPs (unten rechts)
                progress = { enabled = true },
                -- Überschreibt die Standard-LSP-Anzeigen
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.set_autocmd_total"] = true,
                    ["ui.configuration.lsp_doc_border"] = true,
                },
            },
            -- Das sorgt für das schwebende Fenster in der Mitte
            presets = {
                bottom_search = false, -- Suche bleibt unten (oder auch mittig, wenn false)
                command_palette = true, -- Das ist die schwebende Leiste in der Mitte!
                long_message_to_split = true,
                inc_rename = false, -- Nur nötig, wenn du das inc-rename Plugin hättest
                lsp_doc_border = true, -- Schicker Rahmen für LSP Dokus
            },
        },
        dependencies = {
            -- Noice braucht diese beiden Plugins als Unterbau
            "MunifTanjim/nui.nvim",
            -- Optional: Für Benachrichtigungen (die Popups oben rechts)
            "rcarriga/nvim-notify",
        },
    },
    -- Wir fügen nvim-notify direkt hinzu, damit die Popups auch schick aussehen
    {
        "rcarriga/nvim-notify",
        opts = {
            timeout = 3000,
            background_colour = "#000000", -- Passt sich meist selbst an, hilft aber bei Transparenz
            render = "compact", -- Oder "fancy", wenn du mehr Effekte willst
        },
    },
}
