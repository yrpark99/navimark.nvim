local M = {}

local local_nvim_dir = vim.fn.getcwd()
local persist_file = vim.fs.joinpath(local_nvim_dir, "navimark.json")

M.save = function(stacks)
  for _, stack in ipairs(stacks) do
    if vim.tbl_isempty(stack.marks) then
      vim.fn.delete(persist_file, "rf")
      return
    end
  end
  local json = vim.fn.json_encode(stacks)
  vim.fn.writefile({ json }, persist_file)
end

M.load = function()
  if vim.fn.filereadable(persist_file) == 0 then
    return nil
  end
  local json = vim.fn.readfile(persist_file)
  return vim.fn.json_decode(json[1])
end

return M
