return {
  "chrisgrieser/nvim-recorder",
  opts = {
    mapping = {
      startStopRecording = "qq",
      switchSlot = "<C-q>",
      editMacro = "cq",
      playMacro = "Q",
      addBreakPoint = "!!",
      deleteAllMacros = "dq",
    },
  },
  keys = {
    { "qq", desc = "Start macro" },
    { "Q", desc = "Play macro" },
    { "<C-q>", desc = "Switch macro slot" },
    { "dq", desc = "Delete all macros" },
    { "cq", desc = "Edit macro" },
  },
}
