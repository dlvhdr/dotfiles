{ ... }:
{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;

    historyWidgetOptions = [
      "--nth=4.."
      "--preview=''"
      "--border-label=' history '"
      "--prompt='  '"
    ];

    defaultOptions = [
      "--reverse"
      "--border rounded"
      "--no-info"
      "--pointer=''"
      "--marker=' '"
      "--ansi"
      "--height=20%"
      "--color='16,bg+:-1,gutter:-1,prompt:5,pointer:5,marker:6,border:4,label:4,header:italic'"
    ];
  };
}
