return {
    {
        "bomgar/telescope-rage",
        enabled = not vim.g.vscode,
        dependencies = { "nvim-telescope/telescope.nvim" },
        event = "VeryLazy",
        config = function()
            require("telescope").load_extension("rage")
        end,
    }
}
