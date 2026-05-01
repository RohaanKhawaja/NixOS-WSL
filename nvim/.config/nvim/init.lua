-- This is a NixOS Specific init.lua! Please rebuild the system to reload the config

-- Ignore useless warnings 
vim.opt.shortmess:append("I") -- hides some info messages
vim._deprecated = false        -- hides internal deprecated warnings

-- Basic Settings
vim.opt.cursorline = true                          -- Highlight current line
vim.opt.number = true                              -- Line Numbers
vim.opt.relativenumber = true                      -- Relative Line Numbers
vim.opt.wrap = true                                -- Wrap lines
vim.opt.linebreak = true                           -- Only wrap at word boundaries 
vim.opt.showbreak = "↪ "                           -- Show symbol for line breaks 
vim.opt.scrolloff = 11                             -- Keep 10 lines above/below cursor 
vim.opt.sidescrolloff = 9                          -- Keep 8 columns left/right of cursor

-- Indentation
vim.opt.tabstop = 3                                -- Tab width 
vim.opt.shiftwidth = 2                             -- Indent width
vim.opt.softtabstop = 3                            -- Soft tab stop
vim.opt.expandtab = true                           -- Use spaces instead of tabs
vim.opt.smartindent = true                         -- Smart auto-indenting
vim.opt.autoindent = true                          -- Copy indent from current line

-- Search settings
vim.opt.ignorecase = true                          -- Case insensitive search
vim.opt.smartcase = true                           -- Case sensitive if uppercase in search
vim.opt.hlsearch = false                           -- Don't highlight search results 
vim.opt.incsearch = true                           -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true                       -- Enable 25-bit colors
vim.opt.signcolumn = "yes"                         -- Always show sign column
vim.opt.showmatch = true                           -- Highlight matching brackets
vim.opt.matchtime = 3                              -- How long to show matching bracket
vim.opt.cmdheight = 2                              -- Command line height
vim.opt.completeopt = "menuone,noinsert,noselect"  -- Completion options 
vim.opt.showmode = false                           -- Don't show mode in command line 
vim.opt.pumheight = 11                             -- Popup menu height 
vim.opt.pumblend = 11                              -- Popup menu transparency 
vim.opt.winblend = 1                               -- Floating window transparency 
vim.opt.conceallevel = 1                           -- Don't hide markup 
vim.opt.concealcursor = ""                         -- Don't hide cursor line markup 
--vim.opt.lazyredraw = true                          -- Don't redraw during macros
vim.opt.synmaxcol = 301                            -- Syntax highlighting limit 

-- File handling
vim.opt.backup = false                             -- Don't create backup files
vim.opt.writebackup = false                        -- Don't create backup before writing
vim.opt.swapfile = false                           -- Don't create swap files
vim.opt.undofile = true                            -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")  -- Undo directory
vim.opt.updatetime = 301                           -- Faster completion
vim.opt.timeoutlen = 501                           -- Key timeout duration
vim.opt.ttimeoutlen = 1                            -- Key code timeout
vim.opt.autoread = true                            -- Auto reload files changed outside vim
vim.opt.autowrite = false                          -- Don't auto save

-- Behaviour settings
vim.opt.hidden = true                              -- Allow hidden buffers
vim.opt.errorbells = false                         -- No error bells
vim.opt.backspace = "indent,eol,start"             -- Better backspace behaviour
vim.opt.autochdir = false                          -- Don't auto change directory
--vim.opt.iskeyword:append("-")                      -- Treat dash as part of word
vim.opt.path:append("**")                          -- include subdirectories in search
vim.opt.selection = "exclusive"                    -- Selection behavior
vim.opt.mouse = "a"                                -- Enable mouse support
vim.opt.modifiable = true                          -- Allow buffer modifications
vim.opt.clipboard = "unnamedplus"                  -- Use System clipboard

-- Cursor Settings (solid block = normal, solid line = visual, blinking line = insert) 
vim.o.guicursor = table.concat({
  "n:block",                    -- Normal mode: solid block
  "v:ver26",                    -- Visual mode: solid thin vertical bar (25%)
  "i:ver26-blinkwait300-blinkon200-blinkoff150",  -- Insert mode: blinking thin vertical bar
  "c:ver26",                    -- Command-line mode: thin vertical bar
  "r:hor21",                    -- Replace mode: horizontal bar
}, ",")


-- Set leader key to SPACE 
vim.g.mapleader = ' '

-- Delete without yanking by default
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true })
vim.keymap.set('x', 'd', '"_d', { noremap = true })
-- Change without yanking by default
vim.keymap.set('n', 'c', '"_c', { noremap = true })
vim.keymap.set('n', 'C', '"_C', { noremap = true })
vim.keymap.set('x', 'c', '"_c', { noremap = true })

-- Leader + delete = normal delete (yanks)
vim.keymap.set('n', '<Leader>d', 'd', { noremap = true })
vim.keymap.set('n', '<Leader>D', 'D', { noremap = true })
vim.keymap.set('x', '<Leader>d', 'd', { noremap = true })
-- Leader + change = normal change (yanks)
vim.keymap.set('n', '<Leader>c', 'c', { noremap = true })
vim.keymap.set('n', '<Leader>C', 'C', { noremap = true })
vim.keymap.set('x', '<Leader>c', 'c', { noremap = true })


-- Open SumatraPDF (WSL command)
vim.api.nvim_create_user_command("OpenPdf", function()
    -- Get current file (e.g. test.tex)
    local texFile = vim.fn.expand("%:p")

    -- Replace extension with .pdf
    local pdfFile = texFile:gsub("%.tex$", ".pdf")

    -- Check if PDF exists
    if vim.fn.filereadable(pdfFile) == 0 then
        print("PDF not found: " .. pdfFile)
        return
    end

    -- Convert to Windows path
    local winPath = vim.fn.system("wslpath -w " .. pdfFile):gsub("\n", "")

    -- Path to SumatraPDF
    local sumatra = "/mnt/c/Users/Rohaan/AppData/Local/SumatraPDF/SumatraPDF.exe"

    -- Open PDF
    vim.fn.jobstart({sumatra, "-reuse-instance", winPath}, {detach = true})
end, {})

-- Enable spell checking automatically for certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "markdown", "text" },  -- add more if needed
  callback = function()
    -- Set British English for the current buffer
    vim.opt_local.spelllang = "en_gb"

    -- Enable spell checking
    vim.opt_local.spell = true

    -- Optional: highlight current line + nicer undercurl
    vim.cmd("highlight SpellBad gui=undercurl guisp=Red")
    vim.cmd("highlight SpellCap gui=undercurl guisp=Orange")
    vim.cmd("highlight SpellRare gui=undercurl guisp=Blue")
    vim.cmd("highlight SpellLocal gui=undercurl guisp=Green")
  end,
})

-- Save folds on close
vim.opt.viewoptions = "folds,cursor"

vim.api.nvim_create_autocmd("BufWinLeave", {
  callback = function()
    vim.cmd("mkview")
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.cmd("silent! loadview")
  end,
})

-- Plugins Configuration (deferred until after startup)
vim.schedule(function()
  -- Theme
  vim.cmd.colorscheme("dracula")

  -- Statusline
  require("lualine").setup({
    options = {
      theme = "dracula", -- keep your Dracula theme
    },
    sections = {
      lualine_x = {
        {
          require("noice").api.statusline.mode.get,
          cond = require("noice").api.statusline.mode.has,
          color = { fg = "#ff9e64" },
        },
      },
    },
  })
  
  
  -- Indetation indicator 
  require("ibl").setup  ({
  indent = { char =  "│" },   -- pick your indent character
  scope = { enabled = true }, -- highlight current scope
  })

  -- Telescope fuzzy finder
  require("telescope").setup {}

  -- Git signs in gutter
  require("gitsigns").setup()

  -- Treesitter syntax highlighting
  require("nvim-treesitter.configs").setup {
    highlight = { enable = true },
    indent = { enable = true }
  }

  -- Which-key (keybinding hints)
  require("which-key").setup {}

  -- LSP configs
  require("lspconfig").clangd.setup {}
  require("lspconfig").pyright.setup {}
  require("lspconfig").jdtls.setup {}
  require("lspconfig").texlab.setup {}

  local ls = require("luasnip")
  
  -- Optional: load vscode-style snippets (like friendly-snippets)
  --("luasnip.loaders.from_vscode").lazy_load()
  
  -- Define snippets manually
  ls.snippets = ls.snippets or {}  -- ensure the table exists
  ls.snippets.tex = ls.snippets.tex or {}
  
  ls.snippets.tex = vim.list_extend(ls.snippets.tex, {
      -- Environment
      ls.snippet("beg", {
          ls.text_node({"\\begin{"}),
          ls.insert_node(1, "environment"),
          ls.text_node({"}"}),
          ls.insert_node(0),
          ls.text_node({"\\end{"}),
          ls.insert_node(1),
          ls.text_node({"}"})
      }),
      -- Unlabelled equation 
      ls.snippet("eq", {
        ls.text_node({"\\begin{equation*}", "\t"}),
        ls.insert_node(1),
        ls.text_node({"", "\\end{equation*}"}),
      }),
      -- Labelled equation
      ls.snippet("eqn", {
        ls.text_node({"\\begin{equation}", "\t"}),
        ls.insert_node(1),
        ls.text_node({"", "\t\\label{"}),
        ls.insert_node(2, "eq:"),
        ls.text_node({"}", "\\end{equation}"}),
      }),
      -- Fraction
      ls.snippet("fr", {
          ls.text_node({"\\frac{"}),
          ls.insert_node(1),
          ls.text_node({"}{"}),
          ls.insert_node(2),
          ls.text_node({"}"})
      }),
      -- Subscript
      ls.snippet("sub", {
          ls.insert_node(1),
          ls.text_node({"_{"}),
          ls.insert_node(2),
          ls.text_node({"}"})
      }),
      -- Superscript
      ls.snippet("sup", {
          ls.insert_node(1),
          ls.text_node({"^{"}),
          ls.insert_node(2),
          ls.text_node({"}"})
      }),
      -- Inline math
      ls.snippet("im", {
          ls.text_node({"$"}),
          ls.insert_node(1),
          ls.text_node({"$"})
      }),
      -- Display math
      ls.snippet("dm", {
          ls.text_node({"\\[ "}),
          ls.insert_node(1),
          ls.text_node({" \\]"})
      }),
      -- Vectors
      ls.snippet("vec", {
          ls.text_node({"\\vec{"}),
          ls.insert_node(1),
          ls.text_node({"}"})
      }),
      -- Matrices
      ls.snippet("mat", {
          ls.text_node({"\\begin{bmatrix}"}),
          ls.insert_node(1),
          ls.text_node({"\\end{bmatrix}"})
      }),
      -- Bra–ket
      ls.snippet("ket", {
          ls.text_node({"\\lvert "}),
          ls.insert_node(1),
          ls.text_node({" \\rangle"})
      }),
      ls.snippet("bra", {
          ls.text_node({"\\langle "}),
          ls.insert_node(1),
          ls.text_node({" \\rvert"})
      }),
      ls.snippet("braket", {
          ls.text_node({"\\langle "}),
          ls.insert_node(1),
          ls.text_node({" \\vert "}),
          ls.insert_node(2),
          ls.text_node({" \\rangle"})
      }),
      -- Greek letters
      ls.snippet("al", { ls.text_node("\\alpha") }),
      ls.snippet("be", { ls.text_node("\\beta") }),
      ls.snippet("ga", { ls.text_node("\\gamma") }),
      ls.snippet("de", { ls.text_node("\\delta") }),
      ls.snippet("ep", { ls.text_node("\\epsilon") }),
      ls.snippet("la", { ls.text_node("\\lambda") }),
      ls.snippet("mu", { ls.text_node("\\mu") }),
      ls.snippet("si", { ls.text_node("\\sigma") }),
      ls.snippet("th", { ls.text_node("\\theta") }),
      -- Paragraph 
      ls.snippet("par", {
      ls.text_node("\\paragraph{"),
      ls.insert_node(1),
      ls.text_node({"}", ""}),
      ls.insert_node(0),
      }),
      -- Subparagraph
      ls.snippet("spar", {
      ls.text_node("\\subparagraph{"),
      ls.insert_node(1),
      ls.text_node({"}", ""}),
      ls.insert_node(0),
      }),
      -- Section
      ls.snippet("sec", {
      ls.text_node("\\section{"),
      ls.insert_node(1),
      ls.text_node({"}", ""}),
      ls.insert_node(0),
      }),
      -- Subsection
      ls.snippet("ss", {
      ls.text_node("\\subsection{"),
      ls.insert_node(1),
      ls.text_node({"}", ""}),
      ls.insert_node(0),
      }),
      -- Subsubsection
      ls.snippet("sss", {
      ls.text_node("\\subsubsection{"),
      ls.insert_node(1),
      ls.text_node({"}", ""}),
      ls.insert_node(0),
      }),
      -- Subitem 
      ls.snippet("sitem", {
      ls.text_node({ "", "\\subitem " }),
      ls.insert_node(1),
      ls.insert_node(0),
      }),
      -- Itemize 
      ls.snippet("item", {
      ls.text_node({"\\begin{itemize}", "\t\\item "}),
      ls.insert_node(1),
      ls.text_node({"", "\\end{itemize}"}),
      ls.insert_node(0),
      }),
      -- Single item
      ls.snippet("it", {
      ls.text_node({ "", "\\item " }),
      ls.insert_node(1),
      ls.insert_node(0),
      }),
      -- Label
      ls.snippet("lab", {
          ls.text_node({"\\label{"}),
          ls.insert_node(1, "eq:"),
          ls.text_node({"}"}),
      }),
      -- Reference
      ls.snippet("ref", {
          ls.text_node({"\\ref{"}),
          ls.insert_node(1),
          ls.text_node({"}"}),
      }),
      -- Equation reference
      ls.snippet("eqref", {
          ls.text_node({"\\eqref{"}),
          ls.insert_node(1),
          ls.text_node({"}"}),
      }),
      -- Bold text
      ls.snippet("bf", {
          ls.text_node({"\\textbf{"}),
          ls.insert_node(1),
          ls.text_node({"}"}),
      }),
      -- Italic text
      ls.snippet("itx", {
          ls.text_node({"\\textit{"}),
          ls.insert_node(1),
          ls.text_node({"}"}),
      }),
      -- Colour text
      ls.snippet("col", {
          ls.text_node({"\\textcolor{"}),
          ls.insert_node(1, "red"),
          ls.text_node({"}{"}),
          ls.insert_node(2),
          ls.text_node({"}"}),
      }),
      -- Highlight colour box
      ls.snippet("hl", {
          ls.text_node({"\\colorbox{"}),
          ls.insert_node(1, "yellow"),
          ls.text_node({"}{"}),
          ls.insert_node(2),
          ls.text_node({"}"}),
      }),
      -- Align environment (unnumbered)
      ls.snippet("aln", {
          ls.text_node({"\\begin{align*}", "\t"}),
          ls.insert_node(1),
          ls.text_node({"", "\\end{align*}"}),
      }),
      -- Align environment (numbered)
      ls.snippet("alnn", {
          ls.text_node({"\\begin{align}", "\t"}),
          ls.insert_node(1),
          ls.text_node({"", "\\end{align}"}),
      }),
      -- Cases
      ls.snippet("cases", {
          ls.text_node({"\\begin{cases}", "\t"}),
          ls.insert_node(1),
          ls.text_node({"", "\\end{cases}"}),
      }),
      -- Figure
      ls.snippet("fig", {
          ls.text_node({
              "\\begin{figure}[h]",
              "\t\\centering",
              "\t\\includegraphics[width=0.8\\textwidth]{"
          }),
          ls.insert_node(1, "file"),
          ls.text_node({"}", "\t\\caption{"}),
          ls.insert_node(2),
          ls.text_node({"}", "\t\\label{"}),
          ls.insert_node(3, "fig:"),
          ls.text_node({"}", "\\end{figure}"}),
      }),
      -- Itemize
      ls.snippet("itemize", {
          ls.text_node({"\\begin{itemize}", "\t\\item "}),
          ls.insert_node(1),
          ls.text_node({"", "\\end{itemize}"}),
      }),
      -- Enumerate
      ls.snippet("enum", {
          ls.text_node({"\\begin{enumerate}", "\t\\item "}),
          ls.insert_node(1),
          ls.text_node({"", "\\end{enumerate}"}),
      }),
      -- Parentheses
      ls.snippet("lr", {
          ls.text_node({"\\left( "}),
          ls.insert_node(1),
          ls.text_node({" \\right)"}),
      }),
      -- Square brackets
      ls.snippet("lsq", {
          ls.text_node({"\\left[ "}),
          ls.insert_node(1),
          ls.text_node({" \\right]"}),
      }),
      -- Absolute value
      ls.snippet("abs", {
          ls.text_node({"\\left| "}),
          ls.insert_node(1),
          ls.text_node({" \\right|"}),
      }),
      -- Limit
      ls.snippet("lim", {
          ls.text_node({"\\lim_{"}),
          ls.insert_node(1, "n \\to \\infty"),
          ls.text_node({"} "}),
          ls.insert_node(2),
      }),
      -- Small Sum
      ls.snippet("sumsmall", {
          ls.text_node({"\\sum_{"}),
          ls.insert_node(1, "i=1"),
          ls.text_node({"}^{"}),
          ls.insert_node(2, "n"),
          ls.text_node({"} "}),
          ls.insert_node(3),
      }),
      -- Integral
      ls.snippet("int", {
          ls.text_node({"\\int_{"}),
          ls.insert_node(1),
          ls.text_node({"}^{"}),
          ls.insert_node(2),
          ls.text_node({"} "}),
          ls.insert_node(3),
          ls.text_node({" \\, d"}),
          ls.insert_node(4, "x"),
      }),
      -- Table
      ls.snippet("tab", {
          ls.text_node({
              "\\begin{table}[h]",
              "\t\\centering",
              "\t\\begin{tabular}{"
          }),
          ls.insert_node(1, "c"),
          ls.text_node({"}",
              "\t\t"
          }),
          ls.insert_node(2),
          ls.text_node({
              "",
              "\t\\end{tabular}",
              "\t\\caption{"
          }),
          ls.insert_node(3),
          ls.text_node({
              "}",
              "\t\\label{tab:"
          }),
          ls.insert_node(4),
          ls.text_node({
              "}",
              "\\end{table}"
          }),
      }),
      -- Large sum
      ls.snippet("sum", {
          ls.text_node({"\\displaystyle \\sum_{"}),
          ls.insert_node(1, "i=1"),
          ls.text_node({"}^{"}),
          ls.insert_node(2, "n"),
          ls.text_node({"}\\; "}),
          ls.insert_node(3),
      }),
      -- Large Fraction
      ls.snippet("frac", {
          ls.text_node({"\\displaystyle \\frac{"}),
          ls.insert_node(1),
          ls.text_node({"}{"}),
          ls.insert_node(2),
          ls.text_node({"}"}),
      }),
      -- Small fraction
      ls.snippet("fracsmall", {
          ls.insert_node(1),
          ls.text_node({" / "}),
          ls.insert_node(2),
      }),
  })
  
  -- Prioritise custom snippets 
  ls.add_snippets("tex", ls.snippets.tex, { override = true }) 

  -- nvim-cmp setup with LuaSnip for LaTeX
  local cmp = require("cmp")
  
  cmp.setup({
      snippet = {
          expand = function(args)
              ls.lsp_expand(args.body)  -- Expand LuaSnip snippets
          end,
      },
      mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),   -- Trigger completion manually
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
          ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                  cmp.select_next_item()
              elseif ls.expand_or_jumpable() then
                  ls.expand_or_jump()
              else
                  fallback()
              end
          end, { "i", "s" }),
          
          ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                  cmp.select_prev_item()
              elseif ls.jumpable(-1) then
                  ls.jump(-1)
              else
                  fallback()
              end
          end, { "i", "s" }),      
      }),
      sources = cmp.config.sources({
          { name = "nvim_lsp" },    -- LSP completions
          { name = "luasnip" },     -- Snippet completions
          { name = "buffer" },      -- Words from open buffers
          { name = "path" },        -- File path completions
      }),
      completion = {
          completeopt = "menu,menuone,noinsert",  -- How completion menu behaves
          keyword_length = 2,                     -- Trigger after 2 chars
      },
      formatting = {
          format = function(entry, vim_item)
              vim_item.menu = ({
                  nvim_lsp = "[LSP]",
                  luasnip = "[Snip]",
                  buffer = "[Buf]",
                  path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },
    experimental = {
        ghost_text = true,  -- Show preview of completion inline
    },
  })
  
  -- Notify Configuration
  require("notify").setup({
    background_colour = "#000000", -- prevents transparency issues
  })

  vim.notify = require("notify")

  local notifyOk, notify = pcall(require, "notify")
  if notifyOk then
      notify.setup({
          background_colour = "#000000", -- prevents transparency issues
          stages = "fade",               -- smooth fade animation
          timeout = 3000,                -- default timeout for messages
      })
      vim.notify = notify
  end
  
  -- Noice Configuration
  require("noice").setup({
    cmdline = {
      view = "cmdline_popup", -- centres the command line like wofi
    },
    messages = {
      enabled = true, -- replaces default Neovim messages
    },
    popupmenu = {
      enabled = true, -- better completion popup
    },
    presets = {
      bottom_search = false,  -- use popup for search
      command_palette = true, -- position cmdline + popupmenu together
      long_message_to_split = true, -- long messages go into a split
      inc_rename = true, -- enable :IncRename floating input
      lsp_doc_border = true, -- adds borders to hover/signature help
    },
  })
  
  -- VimTeX configuration 
  vim.g.vimtex_view_method = 'tdf'           -- Use TDF inside Kitty
  vim.g.vimtex_quickfix_mode = 0             -- Only show quickfix on errors
  vim.g.vimtex_compiler_method = 'latexmk'   -- Default compiler
  vim.g.vimtex_quickfix_open_on_warning = 0
  vim.g.vimtex_compiler_latexmk = {
    callback = 1,
    continuous = 1,
    executable = 'latexmk',
    options = {
      '-pdf',
      '-interaction=nonstopmode',
      '-synctex=1',
    },
    build_dir = '',
    hooks = {},
    quiet = 1, 
    autoclose = 1, 
  } 
  
  -- Folding settings (deferred for treesitter)
  --vim.opt.foldmethod = "expr"                            -- Use expression for folding
  --vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"   -- Treesitter folding expression
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"        -- Treesitter folding expression
  vim.opt.foldlevel = 99                                 -- Keep all folds open by default
  vim.opt.foldlevelstart = 99                            -- Same as above
  vim.opt.foldenable = true
end)
