local M = {}

local local_nvim_dir = vim.fs.joinpath(vim.fn.getcwd(), ".nvim")
local persist_file = vim.fs.joinpath(local_nvim_dir, "navimark.json")

M.save = function(stacks)
  local json = vim.fn.json_encode(stacks)
  vim.fn.mkdir(local_nvim_dir, "p")
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
