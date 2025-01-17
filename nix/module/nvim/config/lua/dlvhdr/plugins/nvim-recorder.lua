return {
  "chrisgrieser/nvim-recorder",
  opts = {
    mapping = {
      startStopRecording = "q",
      playMacro = "Q",
      addBreakPoint = "!!",
    },
  },
  keys = {
    { "q", desc = "Start Recording" },
    { "Q", desc = "Play Recording" },
    { "cq", desc = "Edit Recording" },
  },
}
