{
  config,
  ...
}:
{
  xdg.configFile."${config.home.homeDirectory}/.local/bin" = {
    source = config.lib.file.mkOutOfStoreSymlink ./bin;
  };

}
