return {
  "chrisgrieser/nvim-recorder",
  opts = {
    mapping = {
      startStopRecording = "qq",
      playMacro = "Q",
      addBreakPoint = "!!",
    },
  },
  keys = {
    { "qq", desc = "Start Recording" },
    { "Q", desc = "Play Recording" },
    { "cq", desc = "Edit Recording" },
  },
}
