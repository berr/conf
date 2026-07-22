local b = {};

-- b.leader = ",";

b.tree = {
    key = "<leader>t",
    group = "Tree",
    items = {
        {key = "t", desc = "Toggle"};
        {key = "f", desc = "Focus"};
        {key = "c", desc = "Close"};
    }
};

b.file= {
    key = "<leader>f",
    group = "File",
    items = {
        {key = "f",desc = "Find file by name"};
        {key = "g",desc = "Find file by content"};
        {key = "s",desc = "Save"};
        {key = "r",desc = "Reload"};
    }
};
b.file.line_ending = {
    key = "E",
    group = "Line Ending",
    items = {
        {key = "w", desc = "Save in DOS line ending"};
        {key = "u", desc = "Save in Unix line ending"};
        {key = "m", desc = "Save in Mac line ending"};
    }
};

b.move = {
    key = "g",
    group = "Move cursor",
    items = {
        {key = "b", desc = "Go to buffers"};
        {key = "?", desc = "Go to Help Tags"};
        {key = "m", desc = "Go to marks"};
        {key = "j", desc = "Go to jumplist"};
        {key = "R", desc = "List registers"};
        {key = "h", desc = "Go to Highlights"};
        {key = "s", desc = "Go to symbols"};
        {key = "S", desc = "Go to symbols in whole workspace"};
        {key = "r", desc = "Go to references to this symbol"};
        {key = "i", desc = "Go to incoming calls"};
        {key = "o", desc = "Go to outgoing calls"};
        {key = "I", desc = "Go to implementations"};
        {key = "d", desc = "Go to definitions"};
        {key = "t", desc = "Go to type definitions"};
    }
};

-- {"<leader>cs",desc = "Select through tree sitter",group = "Select"};
-- {"<leader>csf", function() tos.select_textobject("@function.outer", "textobjects") end,desc = "Select outer function"};
-- {"<leader>csF", function() tos.select_textobject("@function.inner", "textobjects") end,desc = "Select inner function"};
-- {"<leader>csc", function() tos.select_textobject("@class.outer", "textobjects") end,desc = "Select outer class"};
-- {"<leader>csC", function() tos.select_textobject("@class.inner", "textobjects") end,desc = "Select inner class"};
-- {"<leader>csl", function() tos.select_textobject("@class.scope", "locals") end,desc = "Select locals"};
-- {"<leader>gfs", function() tom.goto_next_start("@function.outer", "textobjects") end,desc = "Move to next function start"};
-- {"<leader>gfe", function() tom.goto_next_end("@function.outer", "textobjects") end,desc = "Move to next function end"};
-- {"<leader>gFs", function() tom.goto_previous_start("@function.outer", "textobjects") end,desc = "Move to previous function start"};
-- {"<leader>gFe", function() tom.goto_previous_end("@function.outer", "textobjects") end,desc = "Move to previous function end"};
-- {"<leader>gcs", function() tom.goto_next_start("@class.outer", "textobjects") end,desc = "Move to next class start"};
-- {"<leader>gce", function() tom.goto_next_end("@class.outer", "textobjects") end,desc = "Move to next class end"};
-- {"<leader>gCe", function() tom.goto_previous_start("@class.outer", "textobjects") end,desc = "Move to previous class start"};
-- {"<leader>gCe", function() tom.goto_previous_end("@class.outer", "textobjects") end,desc = "Move to previous class end"};
-- {"<leader>gL",function() tom.goto_next_start({ "@loop.inner", "@loop.outer"}; "textobjects") end, desc = "Move to next loop start/finish" },
-- {"<leader>gl",function() tom.goto_next_start("@local.scope", "locals") end,desc = "Move to next local"};
-- {"<leader>gn",function() tom.goto_next_start("@fold", "folds") end,desc = "Move to next fold"};
-- {"Tab",function() tom.repeat_last_move_nex() end,desc = "Repeat last foward move"};
-- {"<C-Tab>",function() tom.repeat_last_move_previous() end,desc = "Repeat last backward move"};
-- {"<leader>c",desc = "Code actions",group = "Code"};
-- {"<leader>ch", vim.lsp.buf.hover,desc = "Hover"};
-- {"<leader>cS", vim.lsp.buf.signature_help,desc = "Display signature"};
-- {"<leader>ca", vim.lsp.buf.code_action,desc = "Code action"};
-- {"<leader>cr", vim.lsp.buf.rename,desc = "Rename"};
-- {"<leader>cf", vim.lsp.buf.format,desc = "Format file"};
-- {"<leader>cc", function() vim.cmd.RustLsp { 'flyCheck', 'run'}; end, desc = "Format file" },
-- {"<leader>cT", function() vim.cmd.Neotest { 'summary'}; end, desc = "List found tests" };
-- {"<leader>ed", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)"};
-- {"<leader>eD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)"};
-- {"<leader>es", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)"};
-- {"<leader>el", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)"};
-- {"<leader>eL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)"};
-- {"<leader>eQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)"};
-- {"<leader>w",proxy = "<c-w>",group = "Windows"};
-- {"<leader>di",h.toggle_inlay_hints,desc = "Toggle display of inlay hints"};
-- {"<leader>dl",h.toggle_line_numbers,desc = "Toggle display of line numbers"};
-- {"<leader>dL",h.toggle_relative_line_numbers,desc = "Toggle display of relative line numbers"};
-- {"<leader>dw",h.toggle_whitespace,desc = "Toggle display of whitespaces"};
-- {"<leader>dh",":nohl<CR>",desc = "Hide highlights"};
-- {"<leader>s",function() require('grug-far').open({ visualSelectionUsage = 'auto-detect'};) end, desc = "Search/Replace"};
--

-- vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle line comment"};);
-- vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle selection comment"};);
--b

function bprint (t, indent)
  local is_root = (indent == nil)

  if is_root then
    indent = 0
    for k, v in pairs(t) do
        if k ~= "leader" then
            bprint(v, 0)
        end
    end

    return;
  end

  indent_str = string.rep("  ", indent)
  if t.group ~= nil then
    print(indent_str .. t.group .. ": " .. t.key)
    for k, v in pairs(t.items) do
        bprint(v, indent + 1)
    end
    return;
  end

  print(indent_str .. t.desc .. ": " .. t.key)



  -- for k, v in pairs(t) do
  --   formatting = string.rep("  ", indent) .. k .. ": "
  --   if type(v) == "table" then
  --     print(formatting)
  --     tprint(v, indent+1)
  --   elseif type(v) == 'boolean' then
  --     print(formatting .. tostring(v))      
  --   else
  --     print(formatting .. v)
  --   end
  -- end
end

bprint(b)

return b;

