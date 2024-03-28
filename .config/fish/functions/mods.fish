function mods --wraps='mods'
  OPENAI_API_KEY=$(cat ~/.openai) command mods $argv; 
end
